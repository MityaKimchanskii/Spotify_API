//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/6/24.
//

import UIKit


struct UIHelper {
    static func createFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing: CGFloat = 10
        let availableWidth = width - padding*2 - itemSpacing*2
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
