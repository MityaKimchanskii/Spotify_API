//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func tapPlayPause()
    func tapForward()
    func tapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {

    private let imageView = UIImageView()
    private let controlsView = PlayerControlsView()
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBarButtons()
        style()
        layout()
        configure()
    }
    
    private func style() {
        controlsView.delegate = self
        view.backgroundColor = .systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }

}

// MARK: - Actions Delegate
extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func didTapPlayPause(_ playerControlsView: PlayerControlsView) {
        delegate?.tapPlayPause()
    }
    
    func didTapNext(_ playerControlsView: PlayerControlsView) {
        delegate?.tapForward()
    }
    
    func didTapBack(_ playerControlsView: PlayerControlsView) {
        delegate?.tapBackward()
    }
}
