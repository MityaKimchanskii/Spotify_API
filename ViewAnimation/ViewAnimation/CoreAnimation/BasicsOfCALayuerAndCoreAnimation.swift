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
    private let infoLabel = UILabel()

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
        fadeInLabelAnimation()
        cloudAnimation(layer: cloudImage1.layer)
        cloudAnimation(layer: cloudImage2.layer)
        cloudAnimation(layer: cloudImage3.layer)
        cloudFadeInAnimation()
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
        statusImageView.addSubview(messageLabel)
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.backgroundColor = .clear
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        infoLabel.textAlignment = .center
        infoLabel.textColor = .white
        infoLabel.text = "Tap on a field and enter username and password"
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
        view.addSubview(infoLabel)
        
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
            
            infoLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 1),
            infoLabel.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            
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
        rightMove.delegate = self
        rightMove.fromValue = -view.bounds.size.width/2
        rightMove.toValue = view.bounds.size.width/2
        rightMove.duration = 3
        rightMove.fillMode = CAMediaTimingFillMode.both
        rightMove.setValue("form", forKey: "name")
        titleLabel.layer.add(rightMove, forKey: nil)
        
        rightMove.beginTime = CACurrentMediaTime()+1
        rightMove.setValue(usernameTexField.layer, forKey: "layer")
        usernameTexField.layer.add(rightMove, forKey: nil)
     
        rightMove.beginTime = CACurrentMediaTime()+2
        rightMove.setValue(passwordTextField.layer, forKey: "layer")
        passwordTextField.layer.add(rightMove, forKey: nil)
    }

    private func cloudAnimation(layer: CALayer) {
        let cloudSpeed = 60 / Double(view.layer.frame.size.width)
        let duration: TimeInterval = Double(view.layer.frame.size.width - layer.frame.origin.x) * cloudSpeed
        
        let cloudMove = CABasicAnimation(keyPath: "position.x")
        cloudMove.duration = duration
        cloudMove.toValue = self.view.bounds.width + layer.bounds.width / 2
        cloudMove.delegate = self
        cloudMove.setValue("cloud", forKey: "name")
        cloudMove.setValue(layer, forKey: "layer")
        layer.add(cloudMove, forKey: nil)
        
    }
    
    private func cloudFadeInAnimation() {
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 3
        fadeIn.fillMode = CAMediaTimingFillMode.backwards
        cloudImage1.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime()+1
        cloudImage2.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime()+2
        cloudImage3.layer.add(fadeIn, forKey: nil)
    }
    
    private func fadeInLabelAnimation() {
        let leftMove = CABasicAnimation(keyPath: "position.x")
        leftMove.fromValue = infoLabel.layer.position.x + view.frame.size.width
        leftMove.toValue = infoLabel.layer.position.x
        leftMove.duration = 5
        infoLabel.layer.add(leftMove, forKey: "infoappear")
        
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.1
        fadeLabelIn.toValue = 1
        fadeLabelIn.duration = 5
        infoLabel.layer.add(fadeLabelIn, forKey: "fadein")
        
        titleLabel.layer.add(fadeLabelIn, forKey: "fadein")
    }
}

extension BasicsOfCALayuerAndCoreAnimation: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let name = anim.value(forKey: "name") as? String else { return }
        
        if name == "form" {
            let layer = anim.value(forKey: "layer") as? CALayer
            anim.setValue(nil, forKey: "layer")
            
            let pulse = CABasicAnimation(keyPath: "transform.scale")
            pulse.fromValue = 1.25
            pulse.toValue = 1
            pulse.duration = 3
            layer?.add(pulse, forKey: nil)
        }
    }
}
