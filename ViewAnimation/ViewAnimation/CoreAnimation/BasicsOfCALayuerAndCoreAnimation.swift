//
//  BasicsOfCALayuerAndCoreAnimation.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/5/23.
//

import UIKit


class BasicsOfCALayuerAndCoreAnimation: UIViewController {
    
    private let statusMessages = ["Connecting...", "Authorizing...", "Failed..."]
    
    private let titleLabel = UILabel()
    private let usernameTexField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let cloudImage1 = UIImageView()
    private let cloudImage2 = UIImageView()
    private let cloudImage3 = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    private let statusImageView = UIImageView()
    private let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        basicAnimation()
       
    }
}

extension BasicsOfCALayuerAndCoreAnimation {
    private func style() {
        view.backgroundColor = .systemIndigo
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.text = "Welcome!"
        titleLabel.textColor = .white
        
        usernameTexField.translatesAutoresizingMaskIntoConstraints = false
        usernameTexField.placeholder = " Username"
        usernameTexField.backgroundColor = .white
        usernameTexField.isHidden = true
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = " Password"
        passwordTextField.backgroundColor = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.alpha = 0
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .systemYellow
        loginButton.setTitle("Log In", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .primaryActionTriggered)
        loginButton.addSubview(activityIndicator)
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        
        cloudImage1.translatesAutoresizingMaskIntoConstraints = false
        cloudImage1.image = UIImage(systemName: "cloud.fill")
        cloudImage1.tintColor = .green
        
        cloudImage1.translatesAutoresizingMaskIntoConstraints = false
        cloudImage1.image = UIImage(systemName: "cloud.fill")
        cloudImage1.tintColor = .white
        
        cloudImage2.translatesAutoresizingMaskIntoConstraints = false
        cloudImage2.image = UIImage(systemName: "cloud.fill")
        cloudImage2.tintColor = .systemGray
        
        cloudImage3.translatesAutoresizingMaskIntoConstraints = false
        cloudImage3.image = UIImage(systemName: "cloud.fill")
        cloudImage3.tintColor = .red
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        messageLabel.textColor = .systemBrown
        messageLabel.backgroundColor = .clear
        messageLabel.text = "Connecting..."
        
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.image = UIImage(named: "status")
        statusImageView.layer.cornerRadius = 8
        statusImageView.clipsToBounds = true
//        statusImageView.isHidden = true
        statusImageView.addSubview(messageLabel)
    }
    
    private func layout() {
        view.addSubview(cloudImage1)
        view.addSubview(cloudImage2)
        view.addSubview(cloudImage3)
        view.addSubview(titleLabel)
        view.addSubview(usernameTexField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(statusImageView)
        
        NSLayoutConstraint.activate([
            cloudImage1.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 9),
            view.leadingAnchor.constraint(equalToSystemSpacingAfter: cloudImage1.leadingAnchor, multiplier: 1),
            cloudImage1.heightAnchor.constraint(equalToConstant: 60),
            cloudImage1.widthAnchor.constraint(equalToConstant: 90),
            
            cloudImage2.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 30),
            cloudImage2.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 15),
            cloudImage2.heightAnchor.constraint(equalToConstant: 90),
            cloudImage2.widthAnchor.constraint(equalToConstant: 130),
            
            cloudImage3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cloudImage3.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            cloudImage3.heightAnchor.constraint(equalToConstant: 80),
            cloudImage3.widthAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTexField.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            usernameTexField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTexField.heightAnchor.constraint(equalToConstant: 36),
            usernameTexField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: usernameTexField.bottomAnchor, multiplier: 1),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 36),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 8),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 180),
            
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            activityIndicator.leadingAnchor.constraint(equalToSystemSpacingAfter: loginButton.leadingAnchor, multiplier: 2),
            
            statusImageView.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 5),
            statusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: 200),
            statusImageView.heightAnchor.constraint(equalToConstant: 70),
            
            messageLabel.centerXAnchor.constraint(equalTo: statusImageView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor)
        ])
    }

    @objc private func loginButtonTapped() {
       
    }

    private func basicAnimation() {
        let rightMove = CABasicAnimation(keyPath: "position.x")
        rightMove.fromValue = -view.bounds.size.width/2
        rightMove.toValue = view.bounds.size.width/2
        rightMove.duration = 3
        rightMove.fillMode = CAMediaTimingFillMode.both
        titleLabel.layer.add(rightMove, forKey: nil)
        
        rightMove.beginTime = CACurrentMediaTime()+1
        usernameTexField.layer.add(rightMove, forKey: nil)
        usernameTexField.isHidden = false
       
        rightMove.beginTime = CACurrentMediaTime()+2
        passwordTextField.layer.add(rightMove, forKey: nil)
        passwordTextField.isHidden = false
    }

    private func cloudAnimation(cloud: UIImageView, delay: TimeInterval) {
       
    }
}
