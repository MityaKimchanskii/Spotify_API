//
//  BorderColorAnimationView.swift
//  Simple_Animation
//
//  Created by Mitya Kim on 4/23/23.
//

import UIKit

class BorderColorAnimationView: UIView {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        colorAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BorderColorAnimationView {
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "airtag")
        imageView.layer.borderWidth = 10
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.tintColor = .black
    }
    
    private func layout() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func colorAnimation() {
        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = UIColor.black.cgColor
        colorAnimation.toValue = UIColor.systemRed.cgColor
        colorAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        colorAnimation.duration = 3
        colorAnimation.speed = 1
        colorAnimation.repeatCount = .infinity
        colorAnimation.autoreverses = true
        
        imageView.layer.add(colorAnimation, forKey: "borderColor")
    }
}
