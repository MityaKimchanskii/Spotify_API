//
//  RecomendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Mitya Kim on 4/13/23.
//

import UIKit

class RecomendedTrackCollectionViewCell: UICollectionViewCell {
    static let id = "RecomendedTrackCell"
    
    private let albumCoverImageView = UIImageView()
    
    private let trackNameLabel = UILabel()
    
    private let artistNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        contentView.backgroundColor = .secondarySystemBackground
        
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        albumCoverImageView.clipsToBounds = true
        albumCoverImageView.layer.cornerRadius = 5
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
       
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    private func layout() {
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            albumCoverImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            albumCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: 70),
            albumCoverImageView.heightAnchor.constraint(equalToConstant: 70),
            
            trackNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trackNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: albumCoverImageView.trailingAnchor, multiplier: 1),
            
            artistNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: trackNameLabel.bottomAnchor, multiplier: 1),
            artistNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: albumCoverImageView.trailingAnchor, multiplier: 1),
        ])
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artWorkURL)
    }
}
