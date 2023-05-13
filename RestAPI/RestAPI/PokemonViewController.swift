//
//  ViewController.swift
//  RestAPI
//
//  Created by Mitya Kim on 5/13/23.
//

import UIKit

final class PokemonViewController: UIViewController {
    
    private var pokemon: Pokemon?
    
    private let searchBar = UISearchBar()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let idLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension PokemonViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Search Pokemon"
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        imageView.image = UIImage(systemName: "photo")
     
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        nameLabel.textColor = .systemRed
        nameLabel.text = "Pokemon"
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.font = .systemFont(ofSize: 20, weight: .regular)
        idLabel.textColor = .systemRed
        idLabel.text = "ID"
        
    }
    
    private func layout() {
        view.addSubview(searchBar)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: searchBar.bottomAnchor, multiplier: 1),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            idLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func fetchImage() {
        guard let pokemon else { return }
        
        ImageLoader.shared.fetchImage(pokemon) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let name = searchBar.text, !name.isEmpty else { return }
        
        Service.shared.fetchPokemon(name: name) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.pokemon = pokemon
                self?.nameLabel.text = pokemon.name.uppercased()
                self?.idLabel.text = String("Pokemon id: \(pokemon.id)")
                self?.fetchImage()
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
}
