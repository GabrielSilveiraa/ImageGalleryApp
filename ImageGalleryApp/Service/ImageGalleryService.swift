//
//  ImageGalleryService.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import Foundation
import GMSNetworkLayer
import RxSwift

protocol ImageGalleryServiceProtocol: AnyObject {
    func getPhotosList(tag: String, page: Int) -> Single<GalleryPhotosResponse>
    func getPhotosSize(photoId: String) -> Single<ImagesSizeResponse>
}

final class ImageGalleryService {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(session: .shared)) {
        self.networkManager = networkManager
    }
}

extension ImageGalleryService: ImageGalleryServiceProtocol {
    func getPhotosList(tag: String, page: Int) -> Single<GalleryPhotosResponse> {
        return Single.create { [weak self] (single) -> Disposable in
            let route = ImageGalleryApi.photosList(tags: tag, page: page, itemsCount: 100)
            self?.networkManager.request(route) { (result: Result<GalleryPhotosResponse, Error>) in
                switch result {
                case .success(let response):
                    single(.success(response))
                //    onNext(response)
                case .failure(let error):
                    single(.error(error))
                    //observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func getPhotosSize(photoId: String) -> Single<ImagesSizeResponse> {
        return Single.create { [weak self] (single) -> Disposable in
            let route = ImageGalleryApi.photosSize(photoId: photoId)
            self?.networkManager.request(route) { (result: Result<ImagesSizeResponse, Error>) in
                switch result {
                case .success(let response):
                    single(.success(response))
//                    observer.onNext(response)
                case .failure(let error):
                    single(.error(error))
//                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
