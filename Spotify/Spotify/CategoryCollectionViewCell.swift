//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by Mitya Kim on 4/17/23.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let id = "genreCell"
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemCyan,
        .systemYellow,
        .systemOrange,
        .systemGray,
        .systemMint,
        .systemBrown,
        .systemGreen,
        .systemIndigo,
        .systemPurple,
        .systemTeal
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemPink
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "music.quarternote.3")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    
    private func layout() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1),
            
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalToConstant: contentView.height/1.5),
            imageView.widthAnchor.constraint(equalToConstant: contentView.width/1.5)
        ])
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artWork)
        contentView.backgroundColor = colors.randomElement()
    }
    
}
