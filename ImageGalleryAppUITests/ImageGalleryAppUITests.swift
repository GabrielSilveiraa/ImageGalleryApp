//
//  ImageGalleryAppUITests.swift
//  ImageGalleryAppUITests
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import XCTest

class ImageGalleryAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    func testViewInitialized() {
        XCTAssertTrue(app.staticTexts["Gallery"].exists)
        XCTAssertTrue(app.textFields["Search input text"].exists)
        XCTAssertTrue(app.collectionViews["Collection of Images"].exists)
    }
    
    func testImagesRequest() {
        //Needs network connection
        app.textFields["Search input text"].tap()
        app.textFields["Search input text"].typeText("Dog\n")
        let collectionView = app.collectionViews["Collection of Images"]
        XCTAssertTrue(collectionView.cells["ImageCollectionViewCell"]
            .waitForExistence(timeout: 10))
        
        //Uncomment the next few lines and check the infinite scroll happening 🧙🏻‍♂️🔮
//        while true {
//            app.swipeUp()
//        }
    }
}
