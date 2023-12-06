//
//  AutoLayoutAnimation.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/5/23.
//

import UIKit


import UIKit


class AutoLayoutAnimation: UIViewController {
    
    private var topViewHeightConstranint: NSLayoutConstraint?
    private let fruits: [String] = [
        "🍏 Green Apple",
        "🍊 Orange",
        "🍓 Strawberry",
        "🥝 Kiwi",
        "🍌 Banana"
    ]
    private var isOpen = false
    
    private let topView = UIView()
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    private let plusButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setupTableView()
        layout()
    }
}

// MARK: - Extensions
extension AutoLayoutAnimation {
    
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
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = "Open"
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .primaryActionTriggered)
        
    }
    
    private func layout() {
        topView.addSubview(titleLabel)
        topView.addSubview(plusButton)
        view.addSubview(topView)
        view.addSubview(tableView)
        
        topViewHeightConstranint = topView.heightAnchor.constraint(equalToConstant: 80)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topViewHeightConstranint!,
            
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            topView.trailingAnchor.constraint(equalToSystemSpacingAfter: plusButton.trailingAnchor, multiplier: 1),
            plusButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 80),
            plusButton.widthAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
    
    @objc private func plusButtonTapped() {
        isOpen = !isOpen
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [.curveEaseIn]) {
            self.titleLabel.text = self.isOpen ? "Close" : "Open"
            self.topViewHeightConstranint?.constant = self.isOpen ? 160 : 80
            let angle: CGFloat = self.isOpen ? .pi/4 : 0
            self.plusButton.transform = CGAffineTransform(rotationAngle: angle)
            self.view.layoutIfNeeded()
        }
    }
}

extension AutoLayoutAnimation: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fruits[indexPath.row]
        return cell
    }
}
