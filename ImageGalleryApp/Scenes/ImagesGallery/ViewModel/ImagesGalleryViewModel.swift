//
//  ImagesGalleryViewModel.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ImagesGalleryViewModel {
    private struct Constants {
        static let title = "imageGalleryTitle".localized
    }
    
    //MARK: - Private variables
    private let service: ImageGalleryServiceProtocol
    private let concurrentScheduler: SchedulerType
    private let mainScheduler: SchedulerType
    
    private var page = 1
    private var tag = ""
    private var images: [Image] = []
    
    //VieModel should not have disposebag, this is not the bet solution...
    private let disposeBag = DisposeBag()
    
    struct Input {
        let willDisPlayCell: Observable<Int>
        let tag: Observable<String>
    }
    
    struct Output {
        let images: Driver<[Image]>
        let title: Driver<String>
    }
    
    //MARK: - Init
    init(service: ImageGalleryServiceProtocol = ImageGalleryService(),
         concurrentScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .userInteractive),
         mainScheduler: SchedulerType = MainScheduler.instance) {
        self.service = service
        self.mainScheduler = mainScheduler
        self.concurrentScheduler = concurrentScheduler
    }
    
    //MARK: - Input functions
    private func retrieveTagEvent(input: Input) -> Observable<Event<[Image]>> {
        return input.tag
            .filter { !$0.isEmpty }
            .debounce(.milliseconds(300), scheduler: mainScheduler)
            .distinctUntilChanged()
            .do(onNext: {
                self.tag = $0
                self.page = 1
            })
            .observeOn(concurrentScheduler)
            .flatMapLatest({ _ in self.getPhotosList() })
    }
    
    private func retriveScrollEvent(input: Input) -> Observable<Event<[Image]>> {
        input.willDisPlayCell
            .filter {
                $0 >= self.images.count - 30
        }
        .debounce(.seconds(1), scheduler: mainScheduler)
        .do(onNext: { _ in
            self.page += 1
        })
        .observeOn(concurrentScheduler)
        .flatMapLatest({ _ in self.getPhotosList() })
    }
    
    //MARK: - Outputs functions
    private func setupPhotosOutput(event: Observable<Event<[Image]>>) -> Driver<[Image]> {
        return event
            .compactMap { $0.event.element }
            .asDriver(onErrorJustReturn: [])
    }
    
    //MARK: - Service functions
    private func getPhotosList() -> Observable<Event<[Image]>> {
        return
            self.service.getPhotosList(tag: self.tag, page: self.page)
            .asObservable()
            .flatMapLatest({ [weak self] response in
                (self?.getPhotosSize(from: response.gallery.photos) ?? Observable.just([]))
            }).materialize()
    }
    
    private func getPhotosSize(from photos: [Photo]) -> Observable<[Image]> {
        return Observable.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            var images: [Image] = []
            let group = DispatchGroup()
            photos.forEach { photo in
                group.enter()
                self.service.getPhotosSize(photoId: photo.id)
                .subscribe(onSuccess: { response in
                    let image = response.image
                    images.append(image)
                    group.leave()
                }, onError: { _ in
                    group.leave()
                })
                .disposed(by: self.disposeBag)
            }
            group.notify(queue: .main) {
                self.page == 1 ? self.images = images : self.images.append(contentsOf: images)
                observer.onNext(self.images)
            }
            return Disposables.create()
        }
    }
}

//MARK: - ViewModel protocol
extension ImagesGalleryViewModel: ViewModel {
    func transform(input: Input) -> Output {
        let scrollEvent = retriveScrollEvent(input: input)
        let tagEvent = retrieveTagEvent(input: input)
        let requestPhotosEvent = Observable.merge(scrollEvent, tagEvent)
        
        let photosOutput = setupPhotosOutput(event: requestPhotosEvent)
        let titleOutput = Driver.just(Constants.title)
        return Output(images: photosOutput,
                      title: titleOutput)
    }
}
