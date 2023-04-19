//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Mitya Kim on 4/19/23.
//

import UIKit
import SDWebImage

class SearchResultDefaultTableViewCell: UITableViewCell {

    static let id = "searchResultDefaultCell"
    
    private let label = UILabel()
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
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.masksToBounds = true
        
    }
    
    private func layout() {
        addSubview(label)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: iconImageView.trailingAnchor, multiplier: 1),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageURL)
    }
    
}
