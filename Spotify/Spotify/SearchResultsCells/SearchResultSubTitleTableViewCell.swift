//
//  SearchResultSubTitleTableViewCell.swift
//  Spotify
//
//  Created by Mitya Kim on 4/19/23.
//

import UIKit
import SDWebImage

class SearchResultSubTitleTableViewCell: UITableViewCell {

    static let id = "SearchResultSubTitleTableViewCell"
    
    private let label = UILabel()
    private let subtitleLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        subtitleLabel.textColor = .secondaryLabel
        
    }
    
    private func layout() {
        addSubview(label)
        addSubview(iconImageView)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: iconImageView.trailingAnchor, multiplier: 1),
            label.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1),
            subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: iconImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    func configure(with viewModel: SearchResultSubTitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL)
    }
    
}
