//
//  SearchViewController.swift
//  GenreCollectionViewCelly
//
//  Created by Mitya Kim on 4/11/23.
//

import SafariServices
import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    private var categories: [Category] = []
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Albums, Artists, Songs"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        
        return vc
    }()
    
    private lazy var collectionView: UICollectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGenres()
        setupCollectionView()
        style()
        layout()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
//              let query = searchController.searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
//        APICaller.shared.search(with: query) { [weak self] result in
//            switch result {
//            case .success(let results):
//                break
//            case .failure(let error):
//                print(error)
//                print(error.localizedDescription)
//            }
//        }
//        print(query)
    }
}

extension SearchViewController {
    
    private func fetchGenres() {
        APICaller.shared.getCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.configure(with: CategoryCollectionViewCellViewModel(
            title: category.name,
            artWork: URL(string: category.icons.first?.url ?? ""))
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let vc = CategoryViewController(category: category)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth / 2.055 , height: collectionWidth / 2.055)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - Search button Tapped
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        resultsController.delegate = self
        
        APICaller.shared.search(with: query) { [weak self] result in
            switch result {
            case .success(let results):
                resultsController.update(with: results)
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
        print(query)
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResult(_ result: SearchResult) {
        switch result {
        case .artist(let model):
            
            guard let url = URL(string: model.external_urls["spotify"] ?? "") else { return }
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        case .album(let model):
            let vc = AlbumViewController(album: model)
            navigationController?.pushViewController(vc, animated: true)
        case .track(let model):
            break
        case .playlist(let model):
            let vc = PlaylistViewController(playlist: model)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
