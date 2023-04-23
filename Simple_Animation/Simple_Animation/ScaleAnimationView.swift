//
//  ScaleAnimationView.swift
//  Simple_Animation
//
//  Created by Mitya Kim on 4/23/23.
//


import UIKit

class ScaleAnimationView: UIView {
    
    private let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        activateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScaleAnimationView {
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("🔘 Tap!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
    }
    
    private func layout() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func activateButton() {
        button.addTarget(self, action: #selector(buttonDidTap), for: .primaryActionTriggered)
    }
    
    @objc private func buttonDidTap() {
        scaleAnimation()
    }
    
    private func scaleAnimation() {
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        
        scaleAnimation.fromValue = 2
        scaleAnimation.toValue = 1
        scaleAnimation.duration = 5
        scaleAnimation.damping = 10
        
        button.layer.add(scaleAnimation, forKey: "scale")
    }
}
