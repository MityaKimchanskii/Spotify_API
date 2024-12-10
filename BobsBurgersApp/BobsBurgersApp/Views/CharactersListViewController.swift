//
//  ViewController.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//

import UIKit

final class CharactersListViewController: UIViewController {
    
    private let viewModel = CharactersListViewControllerViewModel()
    
    private let tableView = UITableView()
    private let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension CharactersListViewController {
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.id)
        tableView.delegate = viewModel
        tableView.showsVerticalScrollIndicator = false
        viewModel.configureDataSource(tableView: tableView)
        
        searchController.searchBar.placeholder = "Enter name of the character"
        searchController.searchResultsUpdater = viewModel
        searchController.searchBar.delegate = viewModel
        navigationItem.searchController = searchController
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

