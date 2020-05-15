//
//  ImagesGalleryCoordinator.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit

final class ImagesGalleryCoordinator {
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension ImagesGalleryCoordinator: Coordinator {
    func start() {
        let navigationController = UINavigationController()
        navigationController.setupAppearance()
        let viewModel = ImagesGalleryViewModel()
        let viewController = ImagesGalleryViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
