//
//  ImageGalleryApi.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import Foundation
import GMSNetworkLayer

enum ImageGalleryApi: EndPointType {
    case photosList(tags: String, page: Int)
    case photosSize(photoId: String)
    
    private var apiKey: String {
        "f9cc014fa76b098f9e82f1c288379ea1"
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.flickr.com") else {
            fatalError("URL not setted properly")
        }
        return url
    }
    
    var path: String {
        return "/services/rest"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding? {
        return .urlEncoding
    }
    
    var parameters: [String : Any] {
        var parameters = ["api_key": apiKey,
                          "format" : "json",
                          "nojsoncallback" : "1"]
        
        switch self {
        case .photosList(let tags, let page):
            parameters["method"] = "flickr.photos.search"
            parameters["page"] = page.description
            if !tags.isEmpty {
                parameters["tags"] = tags
            }
            
        case .photosSize(let photoId):
            parameters["method"] = "flickr.photos.getSizes"
            parameters["photo_id"] = photoId
        }
        return parameters
    }
    
    
}
