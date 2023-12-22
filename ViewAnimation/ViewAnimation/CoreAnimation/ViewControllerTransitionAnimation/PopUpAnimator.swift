//
//  PopUpAnimator.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/21/23.
//

import UIKit


class PopUpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 1.0
    private var presenting = true
    private var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        containerView.addSubview(toView)
        toView.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
