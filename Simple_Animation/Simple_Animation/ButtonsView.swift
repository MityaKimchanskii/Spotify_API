//
//  ButtonsView.swift
//  Simple_Animation
//
//  Created by Mitya Kim on 4/23/23.
//

import UIKit

class ButtonsView: UIView {
  
    private let stackView = UIStackView()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
        
        buttonsActivation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 20
        stackView.layer.masksToBounds = true
        stackView.spacing = 1
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.setTitle("⬅️", for: .normal)
        leftButton.backgroundColor = .systemPink
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setTitle("➡️", for: .normal)
        rightButton.backgroundColor = .systemCyan
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .systemPink
        
    }
    
    private func layout() {
        addSubview(stackView)
        addSubview(lineView)
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(rightButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 40),
        
            lineView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 5),
            lineView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func buttonsActivation() {
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .primaryActionTriggered)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func leftButtonTapped() {
        UIView.animate(withDuration: 1) {
            self.lineView.backgroundColor = .systemPink
            self.lineView.frame = CGRect(x: 0, y: 48, width: self.stackView.frame.width/2, height: 5)
        }
    }
    
    @objc private func rightButtonTapped() {
        UIView.animate(withDuration: 1) {
            self.lineView.backgroundColor = .systemCyan
            self.lineView.frame = CGRect(x: 100, y: 48, width: self.stackView.frame.width/2, height: 5)
        }
    }
}
