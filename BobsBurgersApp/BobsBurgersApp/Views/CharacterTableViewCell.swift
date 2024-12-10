//
//  CharacterTableViewCell.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//


import UIKit


final class CharacterTableViewCell: UITableViewCell {
    
    static let id = "CharacterTableViewCell"
    
    private let nameLabel = UILabel()
    private let genderLabel = UILabel()
    private let occupationLabel = UILabel()
    private let characterImageView = UIImageView()
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
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFit
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
    }
    
    private func layout() {
        addSubview(characterImageView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(occupationLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalToConstant: 100),
            characterImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            characterImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: characterImageView.bottomAnchor, multiplier: 1),
            
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: characterImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    public func configure(with viewModel: CharacterTableViewCellViewModel) {
        nameLabel.text = viewModel.character.name
        genderLabel.text = viewModel.character.gender
        occupationLabel.text = viewModel.character.occupation
        
        viewModel.isImageLoaded = {
            DispatchQueue.main.async {
                self.characterImageView.image = viewModel.image
            }
        }
    }
}
