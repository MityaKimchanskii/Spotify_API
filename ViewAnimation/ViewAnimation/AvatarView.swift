//
//  AvatarView.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit



class AvatarView: UIView {
    
    private let lineWidth: CGFloat = 6.0
    private let animationDuration = 1.0
    
    private let photoLayer = CALayer()
    
    var shouldTransitionToFinishedState = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createPhotoLayer()
    }
}

extension AvatarView {
    
    private func createPhotoLayer() {
        let batmanImage = UIImage(named: "batman")
        photoLayer.contents = batmanImage?.cgImage
        photoLayer.bounds = CGRect(
            x: .zero,
            y: .zero,
            width: 120,
            height: 120
        )
        
        photoLayer.cornerRadius = 1/2*photoLayer.frame.size.width
        photoLayer.masksToBounds = true

        photoLayer.position = CGPoint(x: 60, y: 0)
        
        layer.addSublayer(photoLayer)
    }
    
    func startAnimation(point: CGPoint, morphSize: CGSize) {
        let originalCenter = center
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.0,
            animations: {
                self.center = point
            }, completion: { _ in
                
            })
        
        UIView.animate(
            withDuration: animationDuration,
            delay: animationDuration,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1.0,
            animations: {
                self.center = originalCenter
            }, completion: { _ in
//                self.delay(seconds: 0.1) {
//                    self.startAnimation(point: point, morphSize: morphSize)
//                }
            })
        
        let morphedFrame = (originalCenter.x < point.x) ?
        
        CGRect(
            x: 0.0,
            y: bounds.height - morphSize.height,
            width: morphSize.width,
            height: morphSize.height) :
        
        CGRect(
            x: bounds.width - morphSize.width,
            y: bounds.height - morphSize.height,
            width: morphSize.width,
            height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
       
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        
        morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        photoLayer.add(morphAnimation, forKey: nil)
    }
    
    private func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
}
