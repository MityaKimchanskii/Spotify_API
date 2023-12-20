//
//  ShapesAndMasksViewController.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit


class ShapesAndMasksViewController: UIViewController {
    
    private let myAvatar = AvatarView()
    private let opponentAvatar = AvatarView()
    
    private let backgroundImage = UIImageView()
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension ShapesAndMasksViewController {
    private func style() {
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "ring")
        backgroundImage.contentMode = .scaleToFill
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Fight!", for: .normal)
        searchButton.backgroundColor = .systemPink
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .primaryActionTriggered)
        searchButton.layer.cornerRadius = 8
        searchButton.clipsToBounds = true
        
        myAvatar.translatesAutoresizingMaskIntoConstraints = false
        opponentAvatar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(searchButton)
        view.addSubview(myAvatar)
        view.addSubview(opponentAvatar)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: searchButton.bottomAnchor, multiplier: 5),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 180),
            
            myAvatar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 35),
            myAvatar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            myAvatar.widthAnchor.constraint(equalToConstant: 120),
            myAvatar.heightAnchor.constraint(equalToConstant: 120),
            
            opponentAvatar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 35),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: opponentAvatar.trailingAnchor, multiplier: 5),
            opponentAvatar.widthAnchor.constraint(equalToConstant: 120),
            opponentAvatar.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc private func searchButtonTapped() {
        let avatarSize = myAvatar.frame.size
        let bounceXOffset: CGFloat = -avatarSize.width / 2
        let morphSize = CGSize(width: avatarSize.width * 0.85, height: avatarSize.height * 1.1)
        
        let rightBouncePoint = CGPoint(x: view.frame.size.width/2.0+bounceXOffset, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(x: view.frame.size.width/2.0-bounceXOffset, y: myAvatar.center.y)
        
        myAvatar.startAnimation(point: rightBouncePoint, morphSize: morphSize)
        opponentAvatar.startAnimation(point: leftBouncePoint, morphSize: morphSize)
    }
}
