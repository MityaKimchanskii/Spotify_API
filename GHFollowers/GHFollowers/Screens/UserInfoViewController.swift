//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/8/24.
//

import UIKit


final class UserInfoViewController: UIViewController {
    
    public var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func layout() {
        
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Actions
extension UserInfoViewController {
    @objc private func didTapDoneButton() {
        dismiss(animated: true)
    }
}


