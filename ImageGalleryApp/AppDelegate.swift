//
//  AppDelegate.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 11/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
    }
}

