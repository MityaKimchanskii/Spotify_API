//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/20/23.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
    
    private var albums: [Album] = []
    
    private let noAlbumsView = ActionLabelView()
    
    private var observer: NSObjectProtocol?
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNoAlbumsView()
        fetchAlbums()
        style()
        layout()
        updateUI()
        
        observer = NotificationCenter.default.addObserver(forName: .albumSavedNotification, object: nil, queue: .main, using: { _ in
            self.fetchAlbums()
        })
    }
}
 
// MARK: - Methods
extension LibraryAlbumsViewController {
    @objc func didTapClose() {
        dismiss(animated: true)
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        noAlbumsView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchResultSubTitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubTitleTableViewCell.id)
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func layout() {
        view.addSubview(noAlbumsView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            noAlbumsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noAlbumsView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 10),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    private func configureNoAlbumsView() {
        noAlbumsView.configure(with: ActionLabelViewViewModel(text: "You have not saved any albums yet.", actionTitle: "Browse"))
    }
    
    private func fetchAlbums() {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbums { [weak self] result in
            switch result {
            case .success(let albums):
                self?.albums = albums
                self?.updateUI()
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUI() {
        if albums.isEmpty {
            noAlbumsView.isHidden = false
            tableView.isHidden = true
        } else {
            noAlbumsView.isHidden = true
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
}

// MARK: - ActionLabelViewDelegate
extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - Delegate, DataSource
extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubTitleTableViewCell.id, for: indexPath) as? SearchResultSubTitleTableViewCell else {
            return UITableViewCell()
        }
        
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultSubTitleTableViewCellViewModel(title: album.name ?? "", subtitle: album.artists.first?.name ?? "", imageURL: URL(string: album.images.first?.url ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        HapticManager.shared.vibrateForSelection()
        
        let album = albums[indexPath.row]
        
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
