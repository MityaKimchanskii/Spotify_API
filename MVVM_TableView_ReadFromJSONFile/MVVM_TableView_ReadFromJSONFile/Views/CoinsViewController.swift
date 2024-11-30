//
//  ViewController.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//

import UIKit

final class CoinsViewController: UIViewController {
    
    private let viewModel = CoinsViewControllerViewModel()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - Helper Methods
extension CoinsViewController {
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.id)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
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

