//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/4/24.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!


extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle )
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activitiIndicator)
        
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activitiIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activitiIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activitiIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyView = GFEmptyStateView(message: message)
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
