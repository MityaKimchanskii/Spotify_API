//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit

class PlayerViewController: UIViewController {

    private let imageView = UIImageView()
    private let controlsView = PlayerControlsView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBarButtons()
        style()
        layout()
    }
    
    private func style() {
        controlsView.delegate = self
        view.backgroundColor = .systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFit
        
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(controlsView)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalToConstant: view.height/2.5),
            
            controlsView.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1),
            controlsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: controlsView.trailingAnchor, multiplier: 1),
            controlsView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1),
        ])
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction() {
        // Actions
    }

}

// MARK: - Actions Delegate
extension PlayerViewController: PlayerControlsViewDelegate {
    func didTapPlayPause(_ playerControlsView: PlayerControlsView) {
        print("play")
    }
    
    func didTapNext(_ playerControlsView: PlayerControlsView) {
        print("next")
    }
    
    func didTapBack(_ playerControlsView: PlayerControlsView) {
        print("back")
    }
}
