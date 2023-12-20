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
    private let circleShalpeLayer = CAShapeLayer()
    private let maskShapeLayer = CAShapeLayer()
    
    var shouldTransitionToFinishedState = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayers()
    }
}

extension AvatarView {
    private func setupLayers() {
        // Draw the photoLayer
        let batmanImage = UIImage(named: "batman")
        photoLayer.contents = batmanImage?.cgImage
        photoLayer.bounds = CGRect(
            x: .zero,
            y: .zero,
            width: 120,
            height: 120
        )
        photoLayer.position = CGPoint(x: 60, y: 0)
        
        // Draw the circleShapeLayer
        circleShalpeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleShalpeLayer.strokeColor = UIColor.white.cgColor
        circleShalpeLayer.lineWidth = lineWidth
        circleShalpeLayer.fillColor = UIColor.clear.cgColor
        circleShalpeLayer.position = CGPoint(x: 0, y: -56)
        
        // Size the maskShapelayer
        maskShapeLayer.path = circleShalpeLayer.path
        maskShapeLayer.position = CGPoint(x: 0.0, y: 10.0)
        
        // add sublayers and mask
        layer.addSublayer(photoLayer)
        photoLayer.mask = maskShapeLayer
        layer.addSublayer(circleShalpeLayer)
    }
    
    func startAnimation(point: CGPoint, morphSize: CGSize) {
        let originalCenter = center
        
        // UIView animation move to center
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0) {
            self.center = point
        }
        
        // UIView animation move to originalCenter
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0,
            animations: { self.center = originalCenter }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.startAnimation(point: point, morphSize: morphSize)
            }
        }
        
        let morphedFrame = (originalCenter.x > point.x) ?
        CGRect(x: 0.0,y: bounds.height - morphSize.height, width: morphSize.width, height: morphSize.height) :
        CGRect(x: bounds.width - morphSize.width, y: bounds.height - morphSize.height, width: morphSize.width, height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        circleShalpeLayer.add(morphAnimation, forKey: nil)
        maskShapeLayer.add(morphAnimation, forKey: nil)
    }
}
