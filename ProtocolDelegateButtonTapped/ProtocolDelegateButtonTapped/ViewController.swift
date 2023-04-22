//
//  ViewController.swift
//  ProtocolDelegateButtonTapped
//
//  Created by Mitya Kim on 4/21/23.
//

import UIKit

class GreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class RedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class ViewController: UIViewController {
    
    private let buttonsView = ButtonsView()
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
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.delegate = self
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.frame.width*2, height: scrollView.frame.height)
        
        greenVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        redVC.view.frame = CGRect(x: view.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
    }
    
    private func layout() {
        view.addSubview(buttonsView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            buttonsView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 7),
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: buttonsView.bottomAnchor, multiplier: 0),
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

extension ViewController: ButtonsViewDelegate {
    func buttonsViewDelegateGreenButtonTapped(_ buttonsView: ButtonsView) {
        print("Green")
    }
    
    func buttonsViewDelegateRedButtonTapped(_ buttonsView: ButtonsView) {
        print("Red")
    }
}

extension ViewController: UIScrollViewDelegate {}



