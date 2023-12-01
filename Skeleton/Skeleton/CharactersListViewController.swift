//
//  ViewController.swift
//  Skeleton
//
//  Created by Mitya Kim on 5/23/23.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    private var isLoaded = false
    
    private var profileCellViewModels: [ProfileCellViewModel] = []
    private var profiles: [Profile] = []
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        setupSkeletons()
        fetchData()
    }
}

extension CharactersListViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.id)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.id)
        tableView.rowHeight = ProfileCell.rowHeight
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
    
    private func fetchData() {
        Networking.shared.fetchCharacters { resulst in
            switch resulst {
            case .success(let profiles):
                self.profiles = profiles
                self.isLoaded = true
                self.configureTableCells(with: profiles)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableCells(with profiles: [Profile]) {
        profileCellViewModels = profiles.map({
            ProfileCellViewModel(id: $0.id, name: $0.name, occupation: $0.occupation ?? " ")
        })
    }
    
    private func setupSkeletons() {
        let row = Profile.makeSceleton()
        profiles = Array(repeating: row, count: 100)
        
        configureTableCells(with: profiles)
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(profileCellViewModels.count)
        return profileCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !profileCellViewModels.isEmpty else { return UITableViewCell() }
        
        if isLoaded {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.id, for: indexPath) as? ProfileCell else {
                return UITableViewCell()
            }
            let profile = profileCellViewModels[indexPath.row]
            cell.configure(with: profile)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.id, for: indexPath) as! SkeletonCell
        return cell
    }
}
