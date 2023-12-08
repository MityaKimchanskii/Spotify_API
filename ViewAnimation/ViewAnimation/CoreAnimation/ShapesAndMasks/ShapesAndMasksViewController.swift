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
    private let statusLabel = UILabel()
    private let versusLabel = UILabel()
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
        searchButton.setTitle("Search Opponent", for: .normal)
        searchButton.backgroundColor = .systemBlue
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .primaryActionTriggered)
        searchButton.layer.cornerRadius = 8
        searchButton.clipsToBounds = true
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Go!"
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        statusLabel.textColor = .systemGreen
        
        versusLabel.translatesAutoresizingMaskIntoConstraints = false
        versusLabel.text = "VS."
        versusLabel.textAlignment = .center
        versusLabel.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        versusLabel.textColor = .systemGreen
        
        myAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        
        opponentAvatar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(backgroundImage)
        view.addSubview(searchButton)
        view.addSubview(statusLabel)
        view.addSubview(versusLabel)
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
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            
            versusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            opponentAvatar.topAnchor.constraint(equalToSystemSpacingBelow: statusLabel.bottomAnchor, multiplier: 15),
            opponentAvatar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            opponentAvatar.widthAnchor.constraint(equalToConstant: 100),
            opponentAvatar.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func searchButtonTapped() {
        
    }
}
