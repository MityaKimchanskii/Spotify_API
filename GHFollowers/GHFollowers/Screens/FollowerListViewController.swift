//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/4/24.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        configureViewController()
        
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemRed
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.id)
    }
    
    private func configureViewController() {
        
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self?.presentGFAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "OK")
            }
        }
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 8
        let itemSpacing: CGFloat = 8
        
        
        let flowLayout = UICollectionViewFlowLayout()
        
        return flowLayout
    }
}
