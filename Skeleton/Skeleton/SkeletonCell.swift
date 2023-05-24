//
//  SceletonCell.swift
//  Skeleton
//
//  Created by Mitya Kim on 5/23/23.
//

import UIKit


final class SkeletonCell: UITableViewCell {
    
    static let id = "SceletonCell"
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let occupationLabel = UILabel()
    
    private let profileImageLayer = CAGradientLayer()
    private let nameLabelLayer = CAGradientLayer()
    private let occupationLabelLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupLayers()
        setupAnimation()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageLayer.frame = profileImageView.bounds
        
        nameLabelLayer.frame = nameLabel.bounds
        nameLabelLayer.cornerRadius = nameLabel.bounds.height/2
        
        occupationLabelLayer.frame = occupationLabel.bounds
        occupationLabelLayer.cornerRadius = occupationLabel.bounds.height/2
    }
}

extension SkeletonCell {
    private func setup() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textAlignment = .left
        nameLabel.textColor = .label
        nameLabel.text = "-Some Name-"
        
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false
        occupationLabel.font = .systemFont(ofSize: 18, weight: .medium)
        occupationLabel.textAlignment = .left
        occupationLabel.textColor = .label
        occupationLabel.numberOfLines = 0
        occupationLabel.text = "-Senior iOS Developer-"
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
    
    private func setupLayers() {
        profileImageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        profileImageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        profileImageView.layer.addSublayer(profileImageLayer)
        
        nameLabelLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLabelLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLabelLayer)
        
        occupationLabelLayer.startPoint = CGPoint(x: 0, y: 0.5)
        occupationLabelLayer.endPoint = CGPoint(x: 1, y: 0.5)
        occupationLabel.layer.addSublayer(occupationLabelLayer)
    }
    
    private func setupAnimation() {
        let imageGroup = makeAnimationGroup()
        imageGroup.beginTime = 0.0
        profileImageLayer.add(imageGroup, forKey: "backgroundColor")
        
        let nameGroup = makeAnimationGroup(previousGroup: imageGroup)
        nameLabelLayer.add(nameGroup, forKey: "backgroundColor")
        
        let occupationGroup = makeAnimationGroup(previousGroup: nameGroup)
        occupationLabelLayer.add(occupationGroup, forKey: "backgroundColor")
    }
}

extension SkeletonCell: SkeletonLoadable {}
