//
//  ServiceTests.swift
//  ImageGalleryAppTests
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import XCTest
import GMSNetworkLayer
@testable import ImageGalleryApp

class ServiceTests: XCTestCase {
    
    func testPhotosListEndpoit() {
        let endpoint = ImageGalleryApi.photosList(tags: "kitten", page: 1)
        XCTAssertEqual(endpoint.baseURL, URL(string: "https://api.flickr.com")!)
        XCTAssertEqual(endpoint.path, "/services/rest")
        XCTAssertEqual(endpoint.httpMethod, .get)
        XCTAssertEqual(endpoint.parameters as! [String: String], ["api_key": "f9cc014fa76b098f9e82f1c288379ea1",
                                                                  "format" : "json",
                                                                  "nojsoncallback" : "1",
                                                                  "method" : "flickr.photos.search",
                                                                  "page" : "1",
                                                                  "tags" : "kitten"])
        XCTAssertEqual(endpoint.encoding, .urlEncoding)
        
    }
    
    func testPhotosListEndpoitWithNoTag() {
        let endpoint = ImageGalleryApi.photosList(tags: "", page: 1)
        XCTAssertEqual(endpoint.parameters as! [String: String], ["api_key": "f9cc014fa76b098f9e82f1c288379ea1",
                                                                  "format" : "json",
                                                                  "nojsoncallback" : "1",
                                                                  "method" : "flickr.photos.search",
                                                                  "page" : "1"])
    }
    
    func testPhotosSizeEndpoint() {
        let endpoint = ImageGalleryApi.photosSize(photoId: "123")
        XCTAssertEqual(endpoint.baseURL, URL(string: "https://api.flickr.com")!)
        XCTAssertEqual(endpoint.path, "/services/rest")
        XCTAssertEqual(endpoint.httpMethod, .get)
        XCTAssertEqual(endpoint.parameters as! [String: String], ["api_key": "f9cc014fa76b098f9e82f1c288379ea1",
                                                                  "format" : "json",
                                                                  "nojsoncallback" : "1",
                                                                  "method" : "flickr.photos.getSizes",
                                                                  "photo_id" : "123"])
        XCTAssertEqual(endpoint.encoding, .urlEncoding)
    }
}

class NetworkManagerMock<U: Decodable>: NetworkManagerProtocol {
    private let result: Result<U, Error>
    
    init(result: Result<U, Error>) {
        self.result = result
    }
    
    func request<T>(_ route: EndPointType, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let result = self.result as! Result<T, Error>
        completion(result)
    }
}
