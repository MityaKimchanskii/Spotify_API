//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistVC = LibraryPLaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildren()
        style()
        layout()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = .systemPink
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        
        playlistVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
    }
    
    private func layout() {
        view.addSubview(scrollView)
        addChild(playlistVC)
        scrollView.addSubview(playlistVC.view)
        playlistVC.didMove(toParent: self)
        addChild(albumsVC)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func addChildren() {
        
    }
}

extension LibraryViewController: UIScrollViewDelegate {
    
}
