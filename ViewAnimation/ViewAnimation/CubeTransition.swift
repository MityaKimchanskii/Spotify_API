//
//  CubeTransition.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/4/23.
//

import UIKit


class CubeTransition: UIViewController {
    
    enum AnimationDirection: Int {
        case positive = 1
        case negative = -1
    }
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cubeTransition(label: label, text: "Animation", direction: .positive)
    }
}

// MARK: - Extensions
extension CubeTransition {
    
    private func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textColor = label.textColor
        auxLabel.textAlignment = label.textAlignment
        
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        label.superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: 5, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseOut], animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        }, completion: { _ in
            label.text = auxLabel.text
            label.transform = .identity
            
            auxLabel.removeFromSuperview()
        })
    }
    
    private func style() {
        view.backgroundColor = .cyan
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = .magenta
        label.textAlignment = .center
        label.text = "Hello World!"
        
    }
    
    private func layout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
