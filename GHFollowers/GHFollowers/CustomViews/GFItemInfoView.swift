//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/8/24.
//

import UIKit


final class GFItemInfoView: UIView {
    
    private let symbolImageView = UIImageView()
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    } 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension GFItemInfoView {
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        
        
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
