//
//  ViewController.swift
//  Add_Child_Class_to_ViewController
//
//  Created by Mitya Kim on 4/22/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let greenVC = GreenViewController()
    private let redVC = RedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildren()
        style()
        layout()
    }

    private func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width*2, height: scrollView.frame.height)
        
        greenVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        redVC.view.frame = CGRect(x: view.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
    }
    
    private func layout() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 7),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 1),
        ])
    }
    
    private func addChildren() {
        addChild(greenVC)
        scrollView.addSubview(greenVC.view)
        greenVC.didMove(toParent: self)
        
        addChild(redVC)
        scrollView.addSubview(redVC.view)
        redVC.didMove(toParent: self)
    }
}

extension ViewController: UIScrollViewDelegate {}



