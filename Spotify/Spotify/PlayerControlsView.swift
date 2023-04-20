//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Mitya Kim on 4/19/23.
//

import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func didTapPlayPause(_ playerControlsView: PlayerControlsView)
    func didTapNext(_ playerControlsView: PlayerControlsView)
    func didTapBack(_ playerControlsView: PlayerControlsView)
}

final class PlayerControlsView: UIView {
    
    private let volumeSlider = UISlider()
    private let nameLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let backButton = UIButton()
    private let nextButton = UIButton()
    private let playPauseButton = UIButton()
    
    weak var delegate: PlayerControlsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        activateBackButton()
        activateNextButton()
        activatePlayPauseButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension PlayerControlsView {
    
    private func style() {
        backgroundColor = .systemBackground
        
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        volumeSlider.value = 0.5
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.text = "Name label"
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.text = "Subtitle label"
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 33, weight: .regular)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .label
        backButton.setImage(UIImage(systemName: "backward.fill", withConfiguration: configuration), for: .normal)
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.tintColor = .label
        playPauseButton.setImage(UIImage(systemName: "pause", withConfiguration: configuration), for: .normal)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.tintColor = .label
        nextButton.setImage(UIImage(systemName: "forward.fill", withConfiguration: configuration), for: .normal)
    }
    
    private func layout() {
        addSubview(volumeSlider)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(backButton)
        addSubview(playPauseButton)
        addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            volumeSlider.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: volumeSlider.trailingAnchor, multiplier: 2),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: volumeSlider.bottomAnchor, multiplier: 3),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            playPauseButton.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            backButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor)
            
        ])
    }
    
    // MARK: - Actions
    private func activateBackButton() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func backButtonTapped() {
        delegate?.didTapBack(self)
    }
    
    private func activateNextButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNext(self)
    }
    
    private func activatePlayPauseButton() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc func playPauseButtonTapped() {
        delegate?.didTapPlayPause(self)
    }
    
}
