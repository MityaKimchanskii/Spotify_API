//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/4/24.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Error", message: errorMessage.errorDescription ?? "Error", buttonTitle: "Ok")
                return
            }
            
            print(followers.count)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
