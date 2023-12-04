//
//  ViewController.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let statusMessages = ["Connecting...", "Authorizing...", "Failed..."]
    
    private let titleLable = UILabel()
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
        
        titleLable.center.x -= view.bounds.width
        usernameTexField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse, .curveEaseOut]) {
            self.titleLable.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
            self.loginButton.center.y -= 30
            self.loginButton.alpha = 1
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.3) {
            self.usernameTexField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.6) {
            self.passwordTextField.center.x += self.view.bounds.width
        }
        
        cloudAnimation(cloud: cloudImage3, delay: 35)
        cloudAnimation(cloud: cloudImage2, delay: 0)
        cloudAnimation(cloud: cloudImage1, delay: 15)
    }
}

extension ViewController {
    private func style() {
        view.backgroundColor = .systemPink
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLable.text = "Welcome!"
        titleLable.textColor = .white
        
        usernameTexField.translatesAutoresizingMaskIntoConstraints = false
        usernameTexField.placeholder = " Username"
        usernameTexField.backgroundColor = .white
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = " Password"
        passwordTextField.backgroundColor = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.alpha = 0
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .systemGreen
        loginButton.setTitle("Log In", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .primaryActionTriggered)
        loginButton.addSubview(activityIndicator)
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        
        cloudImage1.translatesAutoresizingMaskIntoConstraints = false
        cloudImage1.image = UIImage(systemName: "cloud.fill")
        cloudImage1.tintColor = .systemMint
        
        cloudImage1.translatesAutoresizingMaskIntoConstraints = false
        cloudImage1.image = UIImage(systemName: "cloud.fill")
        cloudImage1.tintColor = .systemMint
        
        cloudImage2.translatesAutoresizingMaskIntoConstraints = false
        cloudImage2.image = UIImage(systemName: "cloud.fill")
        cloudImage2.tintColor = .systemBlue
        
        cloudImage3.translatesAutoresizingMaskIntoConstraints = false
        cloudImage3.image = UIImage(systemName: "cloud.fill")
        cloudImage3.tintColor = .systemYellow
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        messageLabel.textColor = .systemBrown
        messageLabel.backgroundColor = .clear
        messageLabel.text = "Connecting..."
        
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.image = UIImage(named: "status")
        statusImageView.layer.cornerRadius = 8
        statusImageView.clipsToBounds = true
        statusImageView.isHidden = true
        statusImageView.addSubview(messageLabel)
    }
    
    private func layout() {
        view.addSubview(cloudImage1)
        view.addSubview(cloudImage2)
        view.addSubview(cloudImage3)
        view.addSubview(titleLable)
        view.addSubview(usernameTexField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(statusImageView)
        
        NSLayoutConstraint.activate([
            cloudImage1.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 9),
            view.leadingAnchor.constraint(equalToSystemSpacingAfter: cloudImage1.leadingAnchor, multiplier: 15),
            cloudImage1.heightAnchor.constraint(equalToConstant: 60),
            cloudImage1.widthAnchor.constraint(equalToConstant: 90),
            
            cloudImage2.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 17),
            view.leadingAnchor.constraint(equalToSystemSpacingAfter: cloudImage2.leadingAnchor, multiplier: 20),
            cloudImage2.heightAnchor.constraint(equalToConstant: 90),
            cloudImage2.widthAnchor.constraint(equalToConstant: 130),
            
            cloudImage3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.leadingAnchor.constraint(equalToSystemSpacingAfter: cloudImage3.leadingAnchor, multiplier: 15),
            cloudImage3.heightAnchor.constraint(equalToConstant: 80),
            cloudImage3.widthAnchor.constraint(equalToConstant: 110),
            
            titleLable.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTexField.topAnchor.constraint(equalToSystemSpacingBelow: titleLable.bottomAnchor, multiplier: 3),
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
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, animations: {
            self.loginButton.bounds.size.width -= 30
            self.loginButton.alpha = 1
        }) { _ in
            self.transitionAnimation(index: 0)
        }
        
        UIView.animate(withDuration: 1) {
            self.activityIndicator.alpha = 1
        }
    }
    
    private func transitionAnimation(index: Int) {
        messageLabel.text = statusMessages[index]
        
        UIView.transition(with: statusImageView, duration: 1, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.statusImageView.isHidden = false
        }) { _ in
           
        }
    }
    
    private func cloudAnimation(cloud: UIImageView, delay: TimeInterval) {
        let cloudSpeed = 30.0 / view.frame.size.width
        let cloudDuration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        
        UIView.animate(withDuration: cloudDuration, delay: delay, options: [.repeat, .curveLinear], animations: {
            cloud.frame.origin.x = self.view.frame.size.width
        }) { _ in
            cloud.frame.origin.x -= cloud.frame.origin.x
        }
    }
}
