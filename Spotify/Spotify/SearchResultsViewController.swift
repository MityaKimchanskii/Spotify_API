//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    private var sections: [SearchSection] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    weak var delegate: SearchResultsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        style()
        layout()
    }
    
    func update(with results: [SearchResult]) {
        
        let artists = results.filter({
            switch $0 {
            case .artist:
                return true
            default:
                return false
            }
        })
        
        let albums = results.filter({
            switch $0 {
            case .album:
                return true
            default:
                return false
            }
        })
        
        let playlists = results.filter({
            switch $0 {
            case .playlist:
                return true
            default:
                return false
            }
        })
        
        let tracks = results.filter({
            switch $0 {
            case .track:
                return true
            default:
                return false
            }
        })
        
        self.sections = [
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Albums", results: albums),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Tracks", results: tracks)
        ]
        
        tableView.reloadData()
        
        if !results.isEmpty {
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
    
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchResultSubTitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubTitleTableViewCell.id)
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.id)
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = sections[indexPath.section].results[indexPath.row]
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubTitleTableViewCell.id, for: indexPath) as? SearchResultSubTitleTableViewCell else {
//            return UITableViewCell()
//        }
        switch result {
        case .artist(let artist):
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultDefaultTableViewCell.id, for: indexPath) as? SearchResultDefaultTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: SearchResultDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL: URL(string: artist.images?.first?.url ?? ""))
            )
            
            return cell
            
        case .album(let album):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubTitleTableViewCell.id, for: indexPath) as? SearchResultSubTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: SearchResultSubTitleTableViewCellViewModel(
                title: album.name ?? "",
                subtitle: album.artists.first?.name ?? "",
                imageURL: URL(string: album.images.first?.url ?? ""))
            )
            
            return cell
            
        case .track(let track):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubTitleTableViewCell.id, for: indexPath) as? SearchResultSubTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: SearchResultSubTitleTableViewCellViewModel(
                title: track.name,
                subtitle: track.artists.first?.name ?? "-",
                imageURL: URL(string: track.album?.images.first?.url ?? ""))
            )
            
            return cell
            
        case .playlist(model: let playlist):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubTitleTableViewCell.id, for: indexPath) as? SearchResultSubTitleTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: SearchResultSubTitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.description,
                imageURL: URL(string: playlist.images.first?.url ?? ""))
            )
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResult(result)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
