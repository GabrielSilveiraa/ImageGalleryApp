//
//  ImagesGalleryView.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit

final class ImagesGalleryView: BaseView {
    //MARK: - UI Variables
    lazy var searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .white
        textField.placeholder = "searchPlaceholder".localized
        textField.layer.cornerRadius = 10
        textField.accessibilityIdentifier = "Search input text"
        return textField
    }()
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.accessibilityIdentifier = "Collection of Images"
        return collectionView
    }()
    
    //MARK: - BaseView functions
    func initialize() {
        backgroundColor = .black
        addSubview(searchTextField, constraints: true)
        addSubview(collectionView, constraints: true)
    }
    
    func setupConstraints() {
        setupSearchTextFieldConstraints()
        setupCollectionViewContraints()
    }
    
    //MARK: - Private functions
    private func setupCollectionViewContraints() {
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    private func setupSearchTextFieldConstraints() {
        searchTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
