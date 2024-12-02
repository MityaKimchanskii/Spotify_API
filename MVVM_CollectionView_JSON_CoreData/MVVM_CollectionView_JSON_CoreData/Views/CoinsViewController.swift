//
//  ViewController.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/1/24.
//

import UIKit

final class CoinsViewController: UIViewController {
    
    private let viewModel = ViewControllerViewModel()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        style()
        layout()
    }
}

// MARK: - Helper Methods
extension CoinsViewController {
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.id)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func style() {
        
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 1),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

