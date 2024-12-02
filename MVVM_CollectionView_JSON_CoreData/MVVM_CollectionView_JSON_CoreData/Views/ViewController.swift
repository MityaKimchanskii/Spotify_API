//
//  ViewController.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/1/24.
//

import UIKit

final class ViewController: UIViewController {
    
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
extension ViewController {
    private func setupCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        
    }
    
    private func style() {
        
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

