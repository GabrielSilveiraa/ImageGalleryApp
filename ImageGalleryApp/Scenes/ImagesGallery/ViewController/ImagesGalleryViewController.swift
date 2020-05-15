//
//  ImagesGalleryViewController.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class ImagesGalleryViewController: ViewCodedViewController<ImagesGalleryView> {
    
    //MARK: - ViewModel
    private let viewModel: ImagesGalleryViewModel
    private lazy var viewModelOutput: ImagesGalleryViewModel.Output = {
        let input = ImagesGalleryViewModel.Input.init(viewDidAppear: rx.viewDidAppear.asObservable(),
                                                      tags: Observable.never())
        return viewModel.transform(input: input)
    }()
    
    //MARK: - Disposebag
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(viewModel: ImagesGalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
      super.viewDidLoad()
      bindViewModel()
    }
    
    //MARK: - Private functions
    private func bindViewModel() {
        
//        viewModelOutput.items.bind(to: customView.collectionView.rx.items(cellIdentifier: "",
//                                                                          cellType: UICollectionViewCell.self)) { _, item, cell in
////            cell.configureCell(withItem: item)
//        }
//        .disposed(by: self.disposeBag)
//        items(cellIdentifier: "", cellType: UICollectionViewCell.self)) {
            
//        }
//        viewModelOutput.itens.bind(to: customView.collectionView.rx.items) {
//            
//        }
//      let inputs = SayHelloViewModel.Input(name: nameTextField.rx.text.orEmpty.asObservable(),
//                                           validate: validateButton.rx.tap.asObservable())
//      let outputs = viewModel.transform(input: inputs)
//      outputs.greeting
//        .drive(greetingLabel.rx.text)
//        .disposed(by: bag)
    }
}
