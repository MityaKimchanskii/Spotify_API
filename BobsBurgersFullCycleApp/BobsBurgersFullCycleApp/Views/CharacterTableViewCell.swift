//
//  CharacterTableViewCell.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import UIKit


final class CharacterTableViewCell: UITableViewCell {
    
    static let id = "CharacterTableViewCell"
    
    private let nameLabel = UILabel()
    private let genderLabel = UILabel()
    private let occupationLabel = UILabel()
    let characteImageView = UIImageView()
    private let stackView = UIStackView()
    
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
extension CharacterTableViewCell {
    private func setup() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .label
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        genderLabel.textColor = .secondaryLabel
        
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false
        occupationLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        occupationLabel.textColor = .secondaryLabel
        
        characteImageView.translatesAutoresizingMaskIntoConstraints = false
        characteImageView.contentMode = .scaleAspectFit
        characteImageView.image = UIImage(systemName: "person")
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
    }
    
    private func layout() {
        addSubview(characteImageView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(occupationLabel)
        
        NSLayoutConstraint.activate([
            characteImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            characteImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: characteImageView.bottomAnchor, multiplier: 1),
            characteImageView.heightAnchor.constraint(equalToConstant: 100),
            characteImageView.widthAnchor.constraint(equalToConstant: 70),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: characteImageView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
    }
    
    func configure(with viewModel: CharacterTableViewCellViewModel) {
        nameLabel.text = viewModel.character.name
        genderLabel.text = viewModel.character.gender
        occupationLabel.text = viewModel.character.occupation
    }
}
