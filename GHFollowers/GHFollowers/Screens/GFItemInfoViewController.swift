//
//  GFItemInfoViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/18/24.
//

import UIKit


class GFItemInfoViewController: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    var user: User
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GFItemInfoViewController {
    private func style() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }
    
    private func layout() {
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: actionButton.bottomAnchor, multiplier: 2),
            actionButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: actionButton.trailingAnchor, multiplier: 2),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
