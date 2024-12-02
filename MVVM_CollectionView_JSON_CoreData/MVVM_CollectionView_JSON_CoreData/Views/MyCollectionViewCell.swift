//
//  CollectionViewCell.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/1/24.
//

import UIKit

final class MyCollectionViewCell: UICollectionViewCell {
    
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let iconImageView = UIImageView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper Methods
extension MyCollectionViewCell {
    private func style() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        symbolLabel.textColor = .systemGray
        symbolLabel.textAlignment = .left
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
    }
    
    private func layout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
    }
}
