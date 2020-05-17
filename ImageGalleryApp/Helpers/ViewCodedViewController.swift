//
//  ViewCoded.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

/*
 https://swiftrocks.com/writing-cleaner-view-code-by-overriding-loadview.html
 */

import UIKit

class ViewCodedViewController<CustomView: BaseView>: UIViewController {
    var customView: CustomView {
        return view as! CustomView //Will never fail as we're overriding 'view'
    }

    override func loadView() {
        //Your custom implementation of this method should not call super.
        //https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview
        view = CustomView()
    }
}
