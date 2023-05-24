//
//  SkeletonLoadable.swift
//  Skeleton
//
//  Created by Mitya Kim on 5/23/23.
//

import UIKit



protocol SkeletonLoadable {}

extension SkeletonLoadable {
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        
        let animationDuration: CFTimeInterval = 1.5
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.systemGray6.cgColor
        anim1.toValue = UIColor.systemGray.cgColor
        anim1.duration = animationDuration
        anim1.beginTime = 0.0
        
        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.systemGray.cgColor
        anim2.toValue = UIColor.systemGray6.cgColor
        anim2.duration = animationDuration
        anim2.beginTime = anim1.beginTime + anim2.duration
        
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false
        
        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        
        return group
    }
}
