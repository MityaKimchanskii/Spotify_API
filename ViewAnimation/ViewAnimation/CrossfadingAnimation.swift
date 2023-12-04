//
//  CrossfadingAnimation.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/3/23.
//

import UIKit


class CrossfadingAnimation: UIViewController {
    
    private let backgroundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fade(imageView: backgroundImage, toImage: UIImage(named: "night"))
    }
}

extension CrossfadingAnimation {
    
    private func style() {
        view.backgroundColor = .white
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "day")
        backgroundImage.contentMode = .scaleToFill
    }
    
    private func layout() {
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func fade(imageView: UIImageView, toImage: UIImage?) {
        UIView.transition(with: imageView, duration: 60, options: [.transitionCrossDissolve, .repeat, .autoreverse], animations: {
            imageView.image = toImage
        }) { _ in
            
        }
    }
}
