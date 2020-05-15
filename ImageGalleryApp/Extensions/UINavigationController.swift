//
//  UINavigationController.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 13/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setupAppearance() {
        navigationBar.barStyle = .black
        navigationBar.backgroundColor = .black
//        navigationBar.barTintColor = .white
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
