//
//  GFAlertViewController.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/4/24.
//

import UIKit


final class GFAlertViewController: UIViewController {
    
    private let containerView = UIView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let bodyLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - Helper Methods
extension GFAlertViewController {
    private func style() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        
        titleLabel.text = alertTitle ?? "Hello World!"
        
        bodyLabel.text = message ?? "Hello Message!"
        
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 2),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            bodyLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            bodyLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 1),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: bodyLabel.trailingAnchor, multiplier: 1),
            actionButton.topAnchor.constraint(equalToSystemSpacingBelow: bodyLabel.bottomAnchor, multiplier: 1),
            
            actionButton.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 2),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: actionButton.trailingAnchor, multiplier: 2),
            containerView.bottomAnchor.constraint(equalToSystemSpacingBelow: actionButton.bottomAnchor, multiplier: 2),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Actions
extension GFAlertViewController {
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}

