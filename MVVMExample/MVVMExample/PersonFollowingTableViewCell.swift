//
//  PersonFollowingTableViewCell.swift
//  MVVMExample
//
//  Created by Mitya Kim on 5/9/23.
//

import UIKit


protocol PersonFollowingTableViewCellDelegate: AnyObject {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingTableViewCell: UITableViewCell {
    
    weak var delegate: PersonFollowingTableViewCellDelegate?
    
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    static let id = "PersonFollowingTableViewCell"
    
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let userNameLabel = UILabel()
    private let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        userNameLabel.text = viewModel.userName
        userImageView.image = viewModel.image
        
        if viewModel.currentlyFollowing {
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.layer.borderColor = UIColor.red.cgColor
            button.layer.borderWidth = 3
        } else {
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.green, for: .normal)
            button.layer.borderColor = UIColor.green.cgColor
            button.layer.borderWidth = 3
        }
    }
    
    private func setup() {
        contentView.clipsToBounds = true
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFit
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textColor = .label
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .label
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTabButton), for: .primaryActionTriggered)
    }
    
    @objc private func didTabButton() {
        guard let viewModel = viewModel else { return }
        
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        delegate?.personFollowingTableViewCell(self, didTapWith: newViewModel)
        configure(with: newViewModel)
    }
    
    private func layout() {
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(nameLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            userImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: userImageView.trailingAnchor, multiplier: 1),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 1),
            
            userNameLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            userNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: userImageView.trailingAnchor, multiplier: 1),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: userNameLabel.trailingAnchor, multiplier: 1),
            
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 1),
            button.widthAnchor.constraint(equalToConstant: 80),
        ])
        
    }
}
