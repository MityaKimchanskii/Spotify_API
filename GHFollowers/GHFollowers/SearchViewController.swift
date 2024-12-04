//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/4/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let logoImageView = UIImageView()
    private let usernameTextField = GFTextField()
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - HelperMethods
extension SearchViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "logo")
        
        usernameTextField.delegate = self
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: logoImageView.bottomAnchor, multiplier: 7),
            usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 6),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 6),
            usernameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            callToActionButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 6),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: callToActionButton.trailingAnchor, multiplier: 6),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: callToActionButton.bottomAnchor, multiplier: 6),
            callToActionButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Actions
extension SearchViewController {
    @objc private func pushFollowerListVC() {
        let followerVC = FollowerListViewController()
        followerVC.username = usernameTextField.text
        followerVC.title = usernameTextField.text
        navigationController?.pushViewController(followerVC, animated: true)
    }
}


// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
