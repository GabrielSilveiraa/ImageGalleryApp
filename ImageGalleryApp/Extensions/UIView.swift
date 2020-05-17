//
//  UIView.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit

extension UIView {
    func addSubview(_ subview: UIView, constraints: Bool) {
        subview.translatesAutoresizingMaskIntoConstraints = !constraints
        self.addSubview(subview)
    }
}
