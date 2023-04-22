//
//  ViewController.swift
//  ProtocolDelegateButtonTapped
//
//  Created by Mitya Kim on 4/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let buttonsView = ButtonsView()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style() {
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.delegate = self
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.text = "Protocol-Delegate"
    }
    
    private func layout() {
        view.addSubview(label)
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 15),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension ViewController: ButtonsViewDelegate {
    func buttonsViewDelegateGreenButtonTapped(_ buttonsView: ButtonsView) {
        label.text = "I am green!"
        label.textColor = .systemGreen
    }
    
    func buttonsViewDelegateRedButtonTapped(_ buttonsView: ButtonsView) {
        label.text = "I am red!"
        label.textColor = .systemRed
    }
}





