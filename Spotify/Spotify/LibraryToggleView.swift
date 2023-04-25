//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Mitya Kim on 4/21/23.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTabPlaylists(_ toggleView: LibraryToggleVeiw)
    func libraryToggleViewDidTabAlbum(_ toggleView: LibraryToggleVeiw)
}

class LibraryToggleVeiw: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    private let playlistButton = UIButton()
    private let albumButton = UIButton()
    private let stackView = UIStackView()
    private let indicatorView = UIView()
    
    weak var delegate: LibraryToggleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        
        activatePlaylistButton()
        activateAlbumButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Methods
extension LibraryToggleVeiw {
    
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        
        playlistButton.translatesAutoresizingMaskIntoConstraints = false
        playlistButton.setTitle("Playlists", for: .normal)
        
        albumButton.translatesAutoresizingMaskIntoConstraints = false
        albumButton.setTitle("Albums", for: .normal)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = .systemGreen
    }
    
    private func layout() {
        addSubview(stackView)
        addSubview(indicatorView)
        stackView.addArrangedSubview(playlistButton)
        stackView.addArrangedSubview(albumButton)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 53),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            
            indicatorView.widthAnchor.constraint(equalToConstant: 100),
            indicatorView.heightAnchor.constraint(equalToConstant: 3),
            indicatorView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0),
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    // Animation indicator
    private func switchStateAndAnimateIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: stackView.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: stackView.bottom, width: 100, height: 3)
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.switchStateAndAnimateIndicator()
        }
    }
}
    
// MARK: - Actions
extension LibraryToggleVeiw {
    private func activatePlaylistButton() {
        playlistButton.addTarget(self, action: #selector(playlistsButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func playlistsButtonTapped() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.switchStateAndAnimateIndicator()
        }
        delegate?.libraryToggleViewDidTabPlaylists(self)
    }
    
    private func activateAlbumButton() {
        albumButton.addTarget(self, action: #selector(albumsButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func albumsButtonTapped() {
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.switchStateAndAnimateIndicator()
        }
        delegate?.libraryToggleViewDidTabAlbum(self)
    }
}
