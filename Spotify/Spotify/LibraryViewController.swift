//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let libraryToggleView = LibraryToggleVeiw()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setupToggleView()
        layout()
    }
    
    private func style() {
        
    }
    
    private func layout() {
        view.addSubview(libraryToggleView)
        
        NSLayoutConstraint.activate([
            libraryToggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            libraryToggleView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func setupToggleView() {
        libraryToggleView.translatesAutoresizingMaskIntoConstraints = false
        libraryToggleView.delegate = self
    }
}

extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTabPlaylists(_ toggleView: LibraryToggleVeiw) {
        print("Playlists")
    }
    
    func libraryToggleViewDidTabAlbum(_ toggleView: LibraryToggleVeiw) {
        print("Albums")
    }
}
