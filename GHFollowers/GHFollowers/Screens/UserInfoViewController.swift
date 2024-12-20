//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/8/24.
//

import UIKit


protocol UserInfoVCDelegate {
    func didTapGithubProfile()
    func didTapGetFollowers()
}


final class UserInfoViewController: UIViewController {
    
    public var username: String!
    
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    
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
                    self.configure(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func configure(with user: User) {
        add(childVC: GFUserInfoHeaderVIewController(user: user), to: headerView)
        
        let repoItemVC = GFRepoItemViewController(user: user)
        repoItemVC.delegate = self
        add(childVC: repoItemVC, to: itemViewOne)
        
        let followingItemVC = GFFollowerItemViewController(user: user)
        followingItemVC.delegate = self
        add(childVC: followingItemVC, to: itemViewTwo)
        
        dateLabel.text = "Github since: \(user.createdAt.convertToDisplay())"
    }
    
    private func layout() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        view.addSubview(dateLabel)
        
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
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: itemViewTwo.bottomAnchor, multiplier: 2),
            dateLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: dateLabel.trailingAnchor, multiplier: 2),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
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

extension UserInfoViewController: UserInfoVCDelegate {
    func didTapGithubProfile() {
        print("hello")
    }
    
    func didTapGetFollowers() {
        print("Bye")
    }
}


