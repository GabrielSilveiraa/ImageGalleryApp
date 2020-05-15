//
//  ImagesGalleryViewModelTests.swift
//  ImageGalleryAppTests
//
//  Created by Gabriel Silveira on 14/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import Quick
import Nimble
import RxBlocking

@testable import ImageGalleryApp

class ImagesGalleryViewModelTests: QuickSpec {
    var viewModel: ImagesGalleryViewModel!
    var service: ImageGalleryServiceStub!
    
    var input: ImagesGalleryViewModel.Input!
    var output: ImagesGalleryViewModel.Output!
    
    var imagesTestable: TestableObserver<[Image]>!
    var titleTestable: TestableObserver<String>!
    
    
    var rx_scheduler: TestScheduler!
    var rx_disposeBag: DisposeBag!
    
    func setupRx() {
        rx_disposeBag = DisposeBag()
        rx_scheduler = TestScheduler(initialClock: 0)
    }
    
    func setupViewModel(serviceError: Bool = false) {
        let photosListResponse: GalleryPhotosResponse = loadJson(filename: "GalleryPhotosResponse")!
        let photosSizeResponse: ImagesSizeResponse = loadJson(filename: "ImagesSizeResponse")!
        
        service = ImageGalleryServiceStub()
        service.photosListResponse = photosListResponse
        service.photosSizeResponse = photosSizeResponse
        service.shouldReturnError = serviceError
        viewModel = ImagesGalleryViewModel(service: service,
                                           concurrentScheduler: rx_scheduler,
                                           mainScheduler: rx_scheduler)
        bindOutput()
        rx_scheduler.start()
    }
    
    func bindOutput() {
        output = viewModel.transform(input: input)
        titleTestable = rx_scheduler.createObserver(String.self)
        imagesTestable = rx_scheduler.createObserver([Image].self)
        
        output.images.drive(imagesTestable).disposed(by: rx_disposeBag)
        output.title.drive(titleTestable).disposed(by: rx_disposeBag)
    }
    
    override func spec() {
        super.spec()
        
        given("ImagesGalleryViewModel") {
            when("The view is setted") {
                beforeEach {
                    self.setupRx()
                    self.input = .init(willDisPlayCell: .never(),
                                       tag: .never())
                    self.setupViewModel()
                }
                
                then("The title should appear") {
                    expect(self.titleTestable.events)
                        .to(equal([Recorded.next(0, "Gallery"), Recorded.completed(0)]))
                }
                when("The user adds a tag") {
                    beforeEach {
                        let didAddTag = self.rx_scheduler.createHotObservable(
                            [Recorded.next(5, "dog")]
                        )
                        self.input = .init(willDisPlayCell: .never(),
                                           tag: didAddTag.asObservable())
                        self.setupViewModel()
                    }
                    then("The service should be called") {
                        expect(self.service.photosListCalled).to(equal(true))
                        expect(self.service.timesPhotosSizeCalled).to(equal(100))
                    }
                    
                    and("The service returns with success") {
                        then("A list of images should appear") {
                            _ = try! self.output.images.toBlocking().first()
                            expect(self.imagesTestable.events.first!.value.element?.count)
                                .to(equal(100))
                            expect(self.imagesTestable.events.first?.value.element?.first!.sizes.first!.source)
                                .to(equal("https://live.staticflickr.com/65535/49884365451_a05f3c104e_s.jpg"))
                        }
                    }
                    and("The service returns an error") {
                        beforeEach {
                            let didAddTag = self.rx_scheduler.createHotObservable(
                                [Recorded.next(5, "dog")]
                            )
                            self.input = .init(willDisPlayCell: .never(),
                                               tag: didAddTag.asObservable())
                            
                            self.setupViewModel(serviceError: true)
                        }
                        then("No events should be sent to driver") {
                            expect(self.imagesTestable.events.count)
                                .to(equal(0))
                        }
                    }
                }
                
                when("The user scrolls to the bottom") {
                    beforeEach {
                        let didAddTag = self.rx_scheduler.createHotObservable(
                            [Recorded.next(5, "dog")]
                        )
                        let willDisplayCell = self.rx_scheduler.createHotObservable(
                            [Recorded.next(10, 100)])
                        self.input = .init(willDisPlayCell: willDisplayCell.asObservable(),
                                           tag: didAddTag.asObservable())
                        self.setupViewModel()
                    }
                    then("The service should  be called again") {
                        expect(self.service.photosListCalled).to(equal(true))
                        expect(self.service.timesPhotosSizeCalled).to(equal(200))
                    }
                    then("The list of images should increase") {
                        _ = try! self.output.images.toBlocking().first()
                        expect(self.imagesTestable.events[1].value.element?.count)
                            .to(equal(200))
                    }
                }
            }
        }
    }
}

class ImageGalleryServiceStub: ImageGalleryServiceProtocol {
    enum ServiceError: Error {
        case fake
    }
    var photosListCalled = false
    var timesPhotosSizeCalled = 0
    var shouldReturnError = false
    var photosListResponse: GalleryPhotosResponse?
    var photosSizeResponse: ImagesSizeResponse?
    
    
    func getPhotosList(tag: String, page: Int) -> Single<GalleryPhotosResponse> {
        photosListCalled = true
        if shouldReturnError {
            return Single.error(ServiceError.fake)
        }
        return Single.just(self.photosListResponse!)
    }
    
    func getPhotosSize(photoId: String) -> Single<ImagesSizeResponse> {
        timesPhotosSizeCalled += 1
        return Single.just(self.photosSizeResponse!)
    }
}
