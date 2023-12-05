//
//  KeyFrame.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/4/23.
//

import UIKit


import UIKit


class KeyFrame: UIViewController {

    private let ballImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        hitTheBall()
    }
}

// MARK: - Extensions
extension KeyFrame {
    
    private func style() {
        view.backgroundColor = .systemTeal
        
        ballImage.translatesAutoresizingMaskIntoConstraints = false
        ballImage.image = UIImage(systemName: "volleyball.fill")
        ballImage.tintColor = .systemOrange
        ballImage.contentMode = .scaleAspectFill
    }
    
    private func layout() {
        view.addSubview(ballImage)
        
        NSLayoutConstraint.activate([
            ballImage.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: ballImage.bottomAnchor, multiplier: 3),
            ballImage.heightAnchor.constraint(equalToConstant: 100),
            ballImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func hitTheBall() {
        let originalCenter = ballImage.center
        
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.25) {
                self.ballImage.center.x += 400
                self.ballImage.center.y -= 500
                self.ballImage.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
              self.ballImage.transform = CGAffineTransform(rotationAngle: 5 * .pi)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                self.ballImage.transform = .identity
                self.ballImage.center = CGPoint(x: 0, y: originalCenter.y)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                self.ballImage.alpha = 1
                self.ballImage.center = originalCenter
            }
        })
    }
}


