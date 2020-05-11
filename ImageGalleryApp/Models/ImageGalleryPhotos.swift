//
//  ImageGalleryPhotos.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import Foundation

// MARK: - GalleryPhotosResponse
struct GalleryPhotosResponse: Decodable {
    let gallery: Gallery
    
    enum CodingKeys: String, CodingKey {
        case gallery = "photos"
    }
}

// MARK: - Gallery
struct Gallery: Decodable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

// MARK: - Photo
struct Photo: Decodable {
    let id: String
}
