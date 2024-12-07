//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/7/24.
//


import UIKit


final class GFEmptyStateView: UIView {
    
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GFEmptyStateView {
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "view")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 20),
            messageLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: messageLabel.trailingAnchor, multiplier: 2),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 15),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
          
        ])
        
    }
}
