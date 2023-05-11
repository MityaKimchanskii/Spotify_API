//
//  ViewController.swift
//  NoStoryboard
//
//  Created by Mitya Kim on 5/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        style()
        layout()
    }
}

extension ViewController {
    private func style() {
        view.backgroundColor = .systemMint
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemPink
        label.text = "No Storyboard"
    }
    
    private func layout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

