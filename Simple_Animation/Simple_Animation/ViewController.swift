//
//  ViewController.swift
//  Simple_Animation
//
//  Created by Mitya Kim on 4/22/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let buttonsView = ButtonsView()
    private let borderAnimationView = BorderColorAnimationView()
    private let scaleView = ScaleAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style() {
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(buttonsView)
        view.addSubview(borderAnimationView)
        view.addSubview(scaleView)
        
        NSLayoutConstraint.activate([
            buttonsView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            buttonsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            borderAnimationView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: borderAnimationView.trailingAnchor, multiplier: 1),
            
            scaleView.topAnchor.constraint(equalToSystemSpacingBelow: buttonsView.bottomAnchor, multiplier: 3),
            scaleView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 7)
        ])
    }
}

