//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/20/24.
//

import UIKit


final class GFFollowerItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
    }
}

// MARK: - Methods
extension GFFollowerItemViewController {
    private func style() {
        itemInfoViewOne.set(itemsInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemsInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers()
    }
}


