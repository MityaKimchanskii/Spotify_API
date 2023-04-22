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
    
    private let playlistButton = UIButton()
    private let albumButton = UIButton()
    private let stackView = UIStackView()
    
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
        playlistButton.backgroundColor = .red
        
        albumButton.translatesAutoresizingMaskIntoConstraints = false
        albumButton.setTitle("Albums", for: .normal)
        albumButton.backgroundColor = .green
    }
    
    private func layout() {
//        addSubview(stackView)
//        stackView.addArrangedSubview(playlistButton)
//        stackView.addArrangedSubview(albumButton)
        addSubview(playlistButton)
//        addSubview(albumButton)
        
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            stackView.heightAnchor.constraint(equalToConstant: 50),
//            stackView.widthAnchor.constraint(equalToConstant: 200)
            
            playlistButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            playlistButton.topAnchor.constraint(equalTo: topAnchor),
            playlistButton.widthAnchor.constraint(equalToConstant: 100),
            playlistButton.heightAnchor.constraint(equalToConstant: 50),
            
//            albumButton.leadingAnchor.constraint(equalTo: playlistButton.trailingAnchor),
//            albumButton.topAnchor.constraint(equalTo: topAnchor),
//            albumButton.widthAnchor.constraint(equalToConstant: 100),
//            albumButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
    
    // MARK: - Actions
extension LibraryToggleVeiw {
    private func activatePlaylistButton() {
        playlistButton.addTarget(self, action: #selector(playlistsButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func playlistsButtonTapped() {
        delegate?.libraryToggleViewDidTabPlaylists(self)
    }
    
    private func activateAlbumButton() {
        albumButton.addTarget(self, action: #selector(albumsButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func albumsButtonTapped() {
        delegate?.libraryToggleViewDidTabAlbum(self)
    }
}
