//
//  ReplicationAnimationViewController.swift
//  ViewAnimation
//
//  Created by Mitya Kim on 12/21/23.
//

import UIKit


class ReplicationAnimationViewController: UIViewController {
    
    private let replicatorLayer = CAReplicatorLayer()
    private let dotLayer = CALayer()
    
    private let dotSize: CGFloat = 20
    private let dotOffset: CGFloat = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        createReplicator()
        
        scaleAnimation()
        
    }
    
}

extension ReplicationAnimationViewController {
    
    private func createReplicator() {
        replicatorLayer.frame = view.bounds
        view.layer.addSublayer(replicatorLayer)
        
        dotLayer.frame = CGRect(x: replicatorLayer.frame.size.width-dotSize,
                                y: replicatorLayer.position.y,
                                width: dotSize,
                                height: dotSize)
        dotLayer.backgroundColor = UIColor.black.cgColor
        
        dotLayer.borderColor = UIColor.red.cgColor
        dotLayer.borderWidth = 1
        dotLayer.cornerRadius = 5
        
        replicatorLayer.addSublayer(dotLayer)
        replicatorLayer.instanceCount = Int(view.frame.size.width/dotSize)
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0, 0)
        replicatorLayer.instanceDelay = 0.5
    }
    
    private func scaleAnimation() {
        let value = [0, 2, 4, 5, 3, 6, 7]
        
        let scale = CABasicAnimation(keyPath: "transform.scale.y")
        scale.fromValue = 0
        scale.toValue = 10
        scale.duration = 0.5
        scale.isRemovedOnCompletion = false
        scale.fillMode = .both
        scale.repeatCount = .infinity
        scale.autoreverses = true
        dotLayer.add(scale, forKey: nil)
        
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = UIColor.cyan.cgColor
        tint.toValue = UIColor.magenta.cgColor
        tint.duration = 0.66
        tint.beginTime = CACurrentMediaTime() + 0.28
        tint.fillMode = .backwards
        tint.repeatCount = .infinity
        tint.autoreverses = true
        tint.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        dotLayer.add(tint, forKey: "dotColor")

        let initialRotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        initialRotation.fromValue = 0.0
        initialRotation.toValue = 0.01
        initialRotation.duration = 0.33
        initialRotation.isRemovedOnCompletion = false
        initialRotation.fillMode = .forwards
        initialRotation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        replicatorLayer.add(initialRotation, forKey: "initialRotation")

        let rotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        rotation.fromValue = 0.01
        rotation.toValue   = -0.01
        rotation.duration = 0.99
        rotation.beginTime = CACurrentMediaTime() + 0.33
        rotation.repeatCount = .infinity
        rotation.autoreverses = true
        rotation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        replicatorLayer.add(rotation, forKey: "replicatorRotation")
    }
}
