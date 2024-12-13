//
//  CharacterListViewController.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import UIKit


final class CharacterListViewController: UIViewController {
    
    private let viewModel: CharacterListViewControllerViewModel
    private let tableView = UITableView()
    
    init(viewModel: CharacterListViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
}

// MARK: - Helper Methods
extension CharacterListViewController {
    private func setup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.id)
        tableView.delegate = viewModel
        viewModel.setupDataSourcef(for: tableView)
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
