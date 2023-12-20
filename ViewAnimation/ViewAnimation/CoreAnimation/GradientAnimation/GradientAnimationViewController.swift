//
//  GradientAnimationViewController.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit


class GradientAnimationViewController: UIViewController {
    
    private let gradientView = GradientView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        style()
        layout()
    }
    
}

extension GradientAnimationViewController {
    private func style() {
        view.backgroundColor = .systemGray3
        gradientView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            gradientView.heightAnchor.constraint(equalToConstant: 100),
            gradientView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: gradientView.trailingAnchor, multiplier: 3),
            gradientView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

