//
//  AnimationKeysAndDelegates.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/6/23.
//

import UIKit


class SpringAnimation: UIViewController {
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        flashButton()
    }
}

// MARK: - Extensions
extension SpringAnimation {
    
    private func style() {
        view.backgroundColor = .yellow
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Push me", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func buttonTapped() {
        let jump = CASpringAnimation(keyPath: "position.y")
        jump.initialVelocity = 100
        jump.mass = 10
        jump.stiffness = 1500
        jump.damping = 50
        jump.fromValue = button.layer.position.y + 30
        jump.toValue = button.layer.position.y
        jump.duration = jump.settlingDuration
        
        button.layer.add(jump, forKey: nil)
    }
    
    private func flashButton() {
        let flash = CASpringAnimation(keyPath: "borderColor")
        flash.damping = 5
        flash.stiffness = 1
        flash.fromValue = UIColor.red.cgColor
        flash.toValue = UIColor.blue.cgColor
        flash.duration = flash.settlingDuration
        flash.repeatCount = .infinity
        button.layer.add(flash, forKey: nil)
    }
}


