//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let libraryToggleView = LibraryToggleVeiw()
    private let scrollView = UIScrollView()
    private let albumsVC = LibraryAlbumsViewController()
    private let playlistsVC = LibraryPLaylistsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildren()
        style()
        setupToggleView()
        layout()
    }
}

// MARK: - Methods
extension LibraryViewController {
    private func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
    }
    
    private func layout() {
        view.addSubview(libraryToggleView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            libraryToggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            libraryToggleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: libraryToggleView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupToggleView() {
        libraryToggleView.translatesAutoresizingMaskIntoConstraints = false
        libraryToggleView.delegate = self
    }
    
    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.didMove(toParent: self)
    }
}

// MARK: - ScrollView Delegate
extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width-100) {
            libraryToggleView.update(for: .album)
        } else {
            libraryToggleView.update(for: .playlist)
        }
    }
}

// MARK: - Protocol-Delegate
extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTabPlaylists(_ toggleView: LibraryToggleVeiw) {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func libraryToggleViewDidTabAlbum(_ toggleView: LibraryToggleVeiw) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
    }
}
