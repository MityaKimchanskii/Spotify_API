//
//  GFRepeItemViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/18/24.
//



import UIKit


final class GFRepeItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - Methods
extension GFRepeItemViewController {
    private func style() {
        itemInfoViewOne.set(itemsInfoType: .repos, with: <#T##Int#>)
    }
    
    private func layout() {
        
        
        NSLayoutConstraint.activate([
            
        ])
    }
}


