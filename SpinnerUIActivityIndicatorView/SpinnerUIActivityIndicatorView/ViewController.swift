//
//  ViewController.swift
//  SpinnerUIActivityIndicatorView
//
//  Created by Mitya Kim on 5/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        stopSpinner()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .systemIndigo
        spinner.hidesWhenStopped = true
    }
    
    private func layout() {
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func stopSpinner() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.spinner.stopAnimating()
        })
    }
}


