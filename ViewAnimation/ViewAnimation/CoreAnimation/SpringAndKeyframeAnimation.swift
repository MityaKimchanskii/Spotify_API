//
//  AnimationKeysAndDelegates.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/6/23.
//

import UIKit


class SpringAndKeyframeAnimation: UIViewController {
    
    private let button = UIButton()
    private let label = UILabel()
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        flashButton()
        flight()
    }
}

// MARK: - Extensions
extension SpringAndKeyframeAnimation {
    
    private func style() {
        view.backgroundColor = .yellow
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.text = "Welcome"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Push me", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemMint
        imageView.image = UIImage(systemName: "balloon.fill")
        imageView.contentMode = .scaleAspectFill
    }
    
    private func layout() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 3),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func buttonTapped() {
        let jump = CASpringAnimation(keyPath: "position.y")
        jump.initialVelocity = 100
        jump.mass = 10
        jump.stiffness = 1500
        jump.damping = 50
        jump.fromValue = button.layer.position.y + 20
        jump.toValue = button.layer.position.y
        jump.duration = jump.settlingDuration
        
        button.layer.add(jump, forKey: nil)
        
        let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
        wobble.duration = 3
        wobble.repeatCount = 5
        wobble.values = [0.0, 90, 180, 270, 360]
        wobble.keyTimes = [0, 0.25, 0.75, 1]
        
        label.layer.add(wobble, forKey: nil)
    }
    
    private func flashButton() {
        let flash = CASpringAnimation(keyPath: "borderColor")
        flash.damping = 50
        flash.stiffness = 10
        flash.fromValue = UIColor.red.cgColor
        flash.toValue = UIColor.blue.cgColor
        flash.duration = flash.settlingDuration
        flash.repeatCount = .infinity
        button.layer.add(flash, forKey: nil)
    }
    
    private func flight() {
        let balloon = CALayer()
        balloon.contents = UIImage(systemName: "balloon.fill")?.cgImage
        
        balloon.frame = CGRect(x: -50, y: 0, width: 60, height: 120)
        view.layer.insertSublayer(balloon, below: label.layer)
        
        let flight = CAKeyframeAnimation(keyPath: "position")
        flight.duration = 12
        flight.values = [
            CGPoint(x: view.frame.width, y: 820),
            CGPoint(x: -50.0, y: 360.0),
            CGPoint(x: view.frame.width, y: 0.0),
        ].map { NSValue(cgPoint: $0) }
        flight.keyTimes = [0.0, 0.5, 1.0]
        
        balloon.add(flight, forKey: nil)
        
        balloon.position = CGPoint(x: -50.0, y: button.center.y)
    }
}
