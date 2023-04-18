//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Mitya Kim on 4/13/23.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let id = "FeaturedPlaylistCell"
    
    private let playlistCoverImageView = UIImageView()
    
    private let playlistNameLabel = UILabel()
    
    private let creatorNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        playlistCoverImageView.translatesAutoresizingMaskIntoConstraints = false
//        playlistCoverImageView.clipsToBounds = true
        playlistCoverImageView.layer.masksToBounds = true
        playlistCoverImageView.layer.cornerRadius = 5
        
        playlistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playlistNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        playlistNameLabel.textAlignment = .center
        
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        creatorNameLabel.textAlignment = .center
    }
    
    private func layout() {
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        
        NSLayoutConstraint.activate([
            playlistCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playlistCoverImageView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            playlistCoverImageView.widthAnchor.constraint(equalToConstant: contentView.height-80),
            playlistCoverImageView.heightAnchor.constraint(equalToConstant: contentView.width-80),
            
            playlistNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: playlistCoverImageView.bottomAnchor, multiplier: 1),
            playlistNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: playlistNameLabel.trailingAnchor, multiplier: 1),
            
            creatorNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: playlistNameLabel.bottomAnchor, multiplier: 1),
            creatorNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: creatorNameLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artWorkURL)
    }
}


