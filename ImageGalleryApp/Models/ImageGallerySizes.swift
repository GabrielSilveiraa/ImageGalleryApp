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
    
    private enum CodingKeys: String, CodingKey {
        case image = "sizes"
    }
}

// MARK: - Image
struct Image: Decodable {
    let sizes: [Size]
    
    private enum CodingKeys: String, CodingKey {
        case sizes = "size"
    }
}

// MARK: - Size
struct Size {
    let label: SizeLabel?
    let width, height: Int
    let source: String
}

extension Size: Decodable {
    private enum CodingKeys: String, CodingKey {
        case label, width, height, source
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let labelString = try container.decode(String.self, forKey: .label)
        self.label = SizeLabel(rawValue: labelString)
        self.height = try container.decode(Int.self, forKey: .height)
        self.width = try container.decode(Int.self, forKey: .width)
        self.source = try container.decode(String.self, forKey: .source)
    }
}

enum SizeLabel: String, Decodable {
    case largeSquare = "Large Square"
    case large = "Large"
}
