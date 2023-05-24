//
//  ProfileCell.swift
//  Skeleton
//
//  Created by Mitya Kim on 5/23/23.
//

import UIKit

struct ProfileCellViewModel {
    let id: Int
    let name: String
    let occupation: String
}

final class ProfileCell: UITableViewCell {
    
    static let id = "ProfileCell"
    static let rowHeight: CGFloat = 151
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let occupationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileCell {
    private func setup() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textAlignment = .left
        nameLabel.textColor = .label
       
        
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false
        occupationLabel.font = .systemFont(ofSize: 18, weight: .medium)
        occupationLabel.textAlignment = .left
        occupationLabel.textColor = .label
        occupationLabel.numberOfLines = 0
    }
    
    private func layout() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(occupationLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            profileImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 135),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 1),
            
            occupationLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            occupationLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImageView.trailingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: occupationLabel.trailingAnchor, multiplier: 1)
        ])
        
    }
    
    public func configure(with viewModel: ProfileCellViewModel) {
        nameLabel.text = viewModel.name
        occupationLabel.text = viewModel.occupation
        fetchImage(with: viewModel.id)
    }
    
    public func fetchImage(with profileID: Int) {
        Networking.shared.fetchProfileImage(profileID: profileID) { result in
            switch result {
            case .success(let image):
                self.profileImageView.image = image 
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
}
