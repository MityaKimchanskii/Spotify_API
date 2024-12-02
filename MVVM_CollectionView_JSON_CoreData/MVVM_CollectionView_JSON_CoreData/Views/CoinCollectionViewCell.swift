//
//  CollectionViewCell.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/1/24.
//

import UIKit

final class CoinCollectionViewCell: UICollectionViewCell {
    
    static let id = "CoinCollectionViewCell"
    
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let percentageLabel = UILabel()
    private let iconImageView = UIImageView()
    private let nameStackView = UIStackView()
    private let priceStackView = UIStackView()
    
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
extension CoinCollectionViewCell {
    private func style() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.3
 
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        symbolLabel.textColor = .systemGray
        symbolLabel.textAlignment = .left
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        priceLabel.textColor = .label
        priceLabel.textAlignment = .right
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        percentageLabel.textAlignment = .right
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .vertical
        nameStackView.spacing = 8
        
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.axis = .vertical
        priceStackView.spacing = 8
    }
    
    private func layout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameStackView)
        contentView.addSubview(priceStackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(symbolLabel)
        
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(percentageLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: ViewSizeContstants.iconHeightAndWidth),
            iconImageView.widthAnchor.constraint(equalToConstant: ViewSizeContstants.iconHeightAndWidth),
            
            nameStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: iconImageView.trailingAnchor, multiplier: 1),
            nameStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: priceStackView.trailingAnchor, multiplier: 1)
        ])
    }
    
    public func configure(with viewModel: MyCollectionViewCellViewModel) {
        nameLabel.text = viewModel.coin.name
        symbolLabel.text = viewModel.coin.symbol.uppercased()
        priceLabel.text = viewModel.formattedPrice
        
        if viewModel.coin.changePercentage < 0 {
            percentageLabel.textColor = .systemRed
        } else {
            percentageLabel.textColor = .systemGreen
        }
        
        percentageLabel.text = "\(viewModel.formattedPercentage)%"
        
        viewModel.onImageDownloaded = {
            DispatchQueue.main.async {
                self.iconImageView.image = viewModel.image
            }
        }
    }
}
