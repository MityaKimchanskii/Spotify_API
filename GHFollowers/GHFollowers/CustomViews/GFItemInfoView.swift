//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/8/24.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}


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
}

extension GFItemInfoView {
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
    }
    
    private func layout() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: symbolImageView.trailingAnchor, multiplier: 1),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalToSystemSpacingBelow: symbolImageView.bottomAnchor, multiplier: 0.5),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemsInfoType: ItemInfoType, with count: Int) {
        switch itemsInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: "heart")
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: "person.2")
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
