//
//  FadeAndBounceTransitions.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/4/23.
//

import UIKit


class FadeAndBounceTransitions: UIViewController {
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fadeAndBounce(label: label, text: "Hero", offset: CGPoint(x: 10, y: 20))
    }
}

// MARK: - Extensions
extension FadeAndBounceTransitions {
    
    func fadeAndBounce(label: UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat, .curveEaseIn]) {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.repeat, .curveEaseIn], animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1.0
        }, completion: { _ in
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1.0
            label.transform = .identity
        })
    }
    
    private func style() {
        view.backgroundColor = .systemCyan
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.text = "iOS"
    }
    
    private func layout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 80),
            label.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}


