//
//  PersonFollowingTableViewCellViewModel.swift
//  MVVMExample
//
//  Created by Mitya Kim on 5/9/23.
//

import UIKit


struct PersonFollowingTableViewCellViewModel {
    let name: String
    let userName: String
    var currentlyFollowing: Bool
    let image: UIImage?
    
    init(with model: Person) {
        name = model.name
        userName = model.username
        currentlyFollowing = false
        image = UIImage(systemName: "person")
    }
}
