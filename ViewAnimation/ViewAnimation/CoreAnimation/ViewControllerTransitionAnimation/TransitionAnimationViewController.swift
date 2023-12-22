//
//  TransitionAnimationViewController.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/21/23.
//

import UIKit


class TransitionAnimationViewController: UIViewController {
    
    private let fruits: [String] = [
        "🍏 Green Apple",
        "🍊 Orange",
        "🍓 Strawberry",
        "🥝 Kiwi",
        "🍌 Banana"
    ]
    
    private let transition = PopUpAnimator()
    
    private let topView = UIView()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setupTableView()
        layout()
    }
}

// MARK: - Extensions
extension TransitionAnimationViewController {
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func style() {
        view.backgroundColor = .systemPink
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .systemGreen
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Choose your favorite fruit"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .white
    }
    
    private func layout() {
        topView.addSubview(titleLabel)
        view.addSubview(topView)
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}

extension TransitionAnimationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fruits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = fruits[indexPath.row]
        print(cell)
    }
}


extension TransitionAnimationViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
