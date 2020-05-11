//
//  ImageGalleryService.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import Foundation
import GMSNetworkLayer

final class ImageGalleryService {
    let networkManager: NetworkManager
    
    init(session: URLSession = .shared) {
        networkManager = NetworkManager(session: session)
    }
}

extension ImageGalleryService {
    func getPhotosList(tags: [String], page: Int, completion: @escaping (Result<GalleryPhotosResponse, Error>) -> Void) {
        var tagsString = ""
        for i in 0..<tags.count {
            tagsString += tags[i]
            if i != tags.count - 1 {
                tagsString += ","
            }
        }
        let route = ImageGalleryApi.photosList(tags: tagsString, page: page)
        networkManager.request(route, completion: completion)
    }
    
    func getPhotosSize(photoId: String, completion: @escaping (Result<ImagesSizeResponse, Error>) -> Void) {
        let route = ImageGalleryApi.photosSize(photoId: photoId)
        networkManager.request(route, completion: completion)
    }
}
