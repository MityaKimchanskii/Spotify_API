//
//  GreenViewController.swift
//  Add_Child_Class_to_ViewController
//
//  Created by Mitya Kim on 4/22/23.
//

import UIKit

class GreenViewController: UIViewController {
    
    private let label = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    private func style() {
        view.backgroundColor = .systemGreen
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .label
        label.text = "Hey, I am green ViewController!"
        label.textAlignment = .center
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .label
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Scroll ➡️"
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(subtitleLabel)
        
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
