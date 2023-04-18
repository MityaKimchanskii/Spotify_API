//
//  AlbumCollectionViewCell.swift
//  Spotify
//
//  Created by Mitya Kim on 4/17/23.
//

import UIKit


class AlbumCollectionViewCell: UICollectionViewCell {
    static let id = "albumCell"
    
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
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
       
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    private func layout() {
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        
        NSLayoutConstraint.activate([
            trackNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            trackNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: trackNameLabel.trailingAnchor, multiplier: 1),
            
            artistNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: trackNameLabel.bottomAnchor, multiplier: 1),
            artistNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: artistNameLabel.trailingAnchor, multiplier: 1)
        ])
    }
    
    func configure(with viewModel: AlbumCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}


