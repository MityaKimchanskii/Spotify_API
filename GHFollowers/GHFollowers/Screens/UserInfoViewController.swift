//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/8/24.
//

import UIKit


final class UserInfoViewController: UIViewController {
    
    public var username: String!
    
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfo()
        style()
        layout()
    }
}

// MARK: - Methods
extension UserInfoViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    guard let user else { return }
                    self.add(childVC: GFUserInfoHeaderVIewController(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemViewController(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemViewController(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func layout() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            headerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: headerView.trailingAnchor, multiplier: 0),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 2),
            itemViewOne.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: itemViewOne.trailingAnchor, multiplier: 2),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalToSystemSpacingBelow: itemViewOne.bottomAnchor, multiplier: 2),
            itemViewTwo.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: itemViewTwo.trailingAnchor, multiplier: 2),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

// MARK: - Actions
extension UserInfoViewController {
    @objc private func didTapDoneButton() {
        dismiss(animated: true)
    }
}


