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
    }
    
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
