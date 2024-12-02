//
//  CollectionViewCell.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/1/24.
//

import UIKit

final class MyCollectionViewCell: UICollectionViewCell {
    
    static let id = "MyCollectionViewCell"
    
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
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
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
 
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        symbolLabel.textColor = .black
        symbolLabel.textAlignment = .left
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .left
        
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
        contentView.addSubview(priceLabel)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 64),
            iconImageView.widthAnchor.constraint(equalToConstant: 64),
            
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: iconImageView.trailingAnchor, multiplier: 1),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: priceLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    public func configure(with viewModel: MyCollectionViewCellViewModel) {
        nameLabel.text = viewModel.coin.name
        symbolLabel.text = viewModel.coin.symbol.uppercased()
        priceLabel.text = viewModel.formattedPrice
        
        viewModel.onImageDownloaded = {
            DispatchQueue.main.async {
                self.iconImageView.image = viewModel.image
            }
        }
    }
}
