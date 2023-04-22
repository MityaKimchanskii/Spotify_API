//
//  ViewButtons.swift
//  ProtocolDelegateButtonTapped
//
//  Created by Mitya Kim on 4/21/23.
//

import UIKit

protocol ButtonsViewDelegate: AnyObject {
    func buttonsViewDelegateGreenButtonTapped(_ buttonsView: ButtonsView)
    func buttonsViewDelegateRedButtonTapped(_ buttonsView: ButtonsView)
}


class ButtonsView: UIView {
    
    private let greenButton = UIButton()
    private let redButton = UIButton()
    private let stackView = UIStackView()
    
    weak var delegate: ButtonsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
        
        activateGreenButton()
        activateRedButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.setTitle("Green", for: .normal)
        greenButton.backgroundColor = .systemGreen
     
        
        redButton.translatesAutoresizingMaskIntoConstraints = false
        redButton.setTitle("Red", for: .normal)
        redButton.backgroundColor = .systemRed
    }
    
    private func layout() {
        addSubview(stackView)
        stackView.addArrangedSubview(greenButton)
        stackView.addArrangedSubview(redButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func activateGreenButton() {
        greenButton.addTarget(self, action: #selector(greenButtonTaped), for: .primaryActionTriggered)
    }
    
    private func activateRedButton() {
        redButton.addTarget(self, action: #selector(redButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func greenButtonTaped() {
        delegate?.buttonsViewDelegateGreenButtonTapped(self)
    }
    
    @objc private func redButtonTapped() {
        delegate?.buttonsViewDelegateRedButtonTapped(self)
    }
}

