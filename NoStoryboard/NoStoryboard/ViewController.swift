//
//  ViewController.swift
//  NoStoryboard
//
//  Created by Mitya Kim on 5/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        style()
        layout()
    }
}

extension ViewController {
    private func style() {
        view.backgroundColor = .systemMint
    }
    
    private func layout() {
        
    }
}

