//
//  ImagesGalleryViewController.swift
//  ImageGalleryApp
//
//  Created by Gabriel Silveira on 12/05/20.
//  Copyright © 2020 Gabriel Silveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ImagesGalleryViewController: ViewCodedViewController<ImagesGalleryView> {
    //MARK: - ViewModel
    private let viewModel: ImagesGalleryViewModel
    private lazy var viewModelOutput: ImagesGalleryViewModel.Output = {
        let input = ImagesGalleryViewModel.Input(willDisPlayCell: willDisPlayCell.asObservable(),
                                                 tag: customView.searchTextField
                                                        .rx.controlEvent([.editingChanged])
                                                        .withLatestFrom(customView.searchTextField.rx.text.orEmpty).asObservable())
        return viewModel.transform(input: input)
    }()
    
    private let willDisPlayCell: PublishSubject<Int> = PublishSubject()
    
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
        setupBinds()
    }
    
    //MARK: - Private functions
    private func setupBinds() {
        viewModelOutput.images
        .drive(customView
                  .collectionView
                  .rx
                  .items(cellIdentifier: ImageCollectionViewCell.identifier,
                         cellType: ImageCollectionViewCell.self)) { row , item, cell in
                            cell.configure(image: item)
        }.disposed(by: disposeBag)
        
        viewModelOutput.title
        .asObservable()
        .bind(to: self.rx.title)
        .disposed(by: disposeBag)
        
        customView.collectionView.rx
        .setDelegate(self)
        .disposed(by: disposeBag)
    }
}

//MARK: - Extension UICollectionViewDelegateFlowLayout
extension ImagesGalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.frame.width * 0.45
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let collectionViewWidth = collectionView.frame.width
        let cellSize = collectionViewWidth * 0.45
        let inset = (collectionViewWidth - 2*cellSize)/3
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
}

extension ImagesGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        willDisPlayCell.onNext(indexPath.row)
    }
}
