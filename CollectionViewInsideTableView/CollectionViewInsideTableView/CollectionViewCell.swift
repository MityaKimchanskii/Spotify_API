//
//  CollectionViewCell.swift
//  CollectionViewInsideTableView
//
//  Created by Mitya Kim on 11/29/23.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    static let id = "CollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCell {
    private func style() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
        label.textColor = .systemPink
    }
    
    private func layout() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
