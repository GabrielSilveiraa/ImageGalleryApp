//
//  ViewModel.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

/*
 https://medium.com/blablacar-tech/rxswift-mvvm-66827b8b3f10
 */

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

