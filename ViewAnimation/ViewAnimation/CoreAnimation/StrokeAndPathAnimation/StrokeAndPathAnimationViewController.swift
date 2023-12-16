//
//  StrokeAndPathAnimation.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit


class StrokeAndPathAnimation: UIViewController {
    
    private let strokeAndPathView = StrokeAndPathView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension StrokeAndPathAnimation {
    private func style() {
        strokeAndPathView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
    }
    
    private func layout() {
        view.addSubview(strokeAndPathView)
        
        NSLayoutConstraint.activate([
            strokeAndPathView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            strokeAndPathView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            strokeAndPathView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            strokeAndPathView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
