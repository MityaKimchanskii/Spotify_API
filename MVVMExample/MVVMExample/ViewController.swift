//
//  ViewController.swift
//  MVVMExample
//
//  Created by Mitya Kim on 5/9/23.
//

import UIKit


class ViewController: UIViewController {
    
    private var models = [Person]()
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        style()
        layout()
    }

    private func style() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PersonFollowingTableViewCell.self, forCellReuseIdentifier: PersonFollowingTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureModels() {
        let names = ["Dmitrii", "David", "Newthon", "Jack", "Nikolay", "Victor", "Ivan"]
        
        for name in names {
            models.append(Person(name: name))
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingTableViewCell.id, for: indexPath) as? PersonFollowingTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.configure(with: PersonFollowingTableViewCellViewModel(with: model))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

extension ViewController: PersonFollowingTableViewCellDelegate {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        
    }
}
