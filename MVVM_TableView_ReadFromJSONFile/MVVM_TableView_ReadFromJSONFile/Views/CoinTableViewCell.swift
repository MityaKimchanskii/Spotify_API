//
//  CoinTableViewCell.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//

import UIKit
import Combine

class CoinTableViewCell: UITableViewCell {
    
    static let id = "CoinTableViewCell"

    private let stackView = UIStackView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let coinImageView = UIImageView()
    private let currentPriceLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper Methods
extension CoinTableViewCell {
    private func setup() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .label
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        symbolLabel.textColor = .systemGray
        
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPriceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        currentPriceLabel.textColor = .label
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        coinImageView.contentMode = .scaleAspectFit
        coinImageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
    }
    
    private func layout() {
        addSubview(coinImageView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
        
        addSubview(currentPriceLabel)
        
        NSLayoutConstraint.activate([
            coinImageView.heightAnchor.constraint(equalToConstant: 32),
            coinImageView.widthAnchor.constraint(equalToConstant: 32),
            coinImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: coinImageView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            
            currentPriceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: currentPriceLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    public func configure(with viewModel: CoinTableViewCellViewModel) {
        nameLabel.text = viewModel.coin.name
        symbolLabel.text = viewModel.coin.symbol.uppercased()
        currentPriceLabel.text = viewModel.formattedPrice
        
        
        viewModel.onImageDowloaded = { [weak self] in
            DispatchQueue.main.async {
                self?.coinImageView.image = viewModel.image
            }
        }
    }
}
