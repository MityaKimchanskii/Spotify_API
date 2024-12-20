//
//  GFRepeItemViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/18/24.
//



import UIKit


final class GFRepoItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - Methods
extension GFRepoItemViewController {
    private func style() {
        itemInfoViewOne.set(itemsInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemsInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    private func layout() {
        
        
        NSLayoutConstraint.activate([
            
        ])
    }
}


