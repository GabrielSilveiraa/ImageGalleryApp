//
//  BaseView.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit

/**
   **A Custom UIView class designed to use with layout view coded**
   **Lifecycle:**
   1. `init()`
   2. `initialize()` *Add subviews*
   3. `installConstraints()` *Setup constraints*
*/
typealias BaseView = BaseViewClass & BaseViewProtocol

protocol BaseViewProtocol {
    func initialize()
    func setupConstraints()
}

class BaseViewClass: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: UIScreen.main.bounds)
        self.setup()
    }
    
    private func setup() {
        guard let self = self as? BaseView else {
            fatalError("Use BaseView instead of BaseViewClass")
        }
        self.initialize()
        self.setupConstraints()
    }
}
