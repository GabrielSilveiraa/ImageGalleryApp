//
//  ImageGallerySizes.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import Foundation

// MARK: - ImagesSizeResponse
struct ImagesSizeResponse: Decodable {
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case image = "sizes"
    }
}

// MARK: - Image
struct Image: Decodable {
    let sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case sizes = "size"
    }
}

// MARK: - Size
struct Size: Decodable {
    let label: SizeLabel?
    let width, height: Int
    let source: String
}

enum SizeLabel: String, Decodable {
    case largeSquare = "Large Square"
    case square = "Square"
    case thumbnail = "Thumbnail"
    case small = "Small"
    case small320 = "Small 320"
    case small400 = "Small 400"
    case medium = "Medium"
    case medium640 = "Medium 640"
    case medium800 = "Medium 800"
    case large = "Large"
    case large1600 = "Large 1600"
    case large2048 = "Large 2048"
    case xLarge3K = "X-Large 3K"
    case xLarge4K = "X-Large 4K"
}

