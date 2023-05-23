//
//  ConstraintAnimation.swift
//  Simple_Animation
//
//  Created by Mitya Kim on 5/22/23.
//


import UIKit


final class ConstraintAnimation: UIView {
    
    private let label = UILabel()
    private var labelLeadingAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}

extension ConstraintAnimation {
    
    private func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPurple
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Hello World!"
        label.textAlignment = .center
    }
    
    private func layout() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        labelLeadingAnchor = label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -1000)
        labelLeadingAnchor?.isActive = true
    }
}


extension ConstraintAnimation {
    public func animate() {
        let animation1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.labelLeadingAnchor?.constant = 0
            self.layoutIfNeeded()
        }
        animation1.startAnimation()
    }
}

