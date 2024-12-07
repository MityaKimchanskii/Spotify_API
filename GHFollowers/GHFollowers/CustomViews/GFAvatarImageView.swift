//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/5/24.
//
import UIKit


final class GFAvatarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(systemName: "bitcoinsign.circle.fill")
        translatesAutoresizingMaskIntoConstraints = false
    }
}
