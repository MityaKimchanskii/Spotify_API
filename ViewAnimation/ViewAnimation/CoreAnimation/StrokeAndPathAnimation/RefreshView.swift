//
//  RefreshView.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit
import QuartzCore

protocol RefreshViewDelegate: AnyObject {
    func refreshViewDidRefresh(_ refreshView: RefreshView)
}

class RefreshView: UIView {
    
    weak var delegate: RefreshViewDelegate?
    
    private var scrollView: UIScrollView
    private var refreshing = false
    private var progress: CGFloat = 0
    
    private var isRefreshing = false
    
    private let ovalShapeLayer = CAShapeLayer()
    private let airplaneLayer = CALayer()
    
    init(frame: CGRect, scrollView: UIScrollView) {
        self.scrollView = scrollView
        
        super.init(frame: frame)
        
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 4
        ovalShapeLayer.lineDashPattern = [2,3]
        
        let refreshRadius = frame.size.height/2*0.8
        
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(
            x: frame.size.width/2-refreshRadius,
            y: frame.size.height/2-refreshRadius,
            width: refreshRadius*2,
            height: refreshRadius*2
        )).cgPath
        
        layer.addSublayer(ovalShapeLayer)
        
        if let airplaneImage = UIImage(named: "airplane") {
            airplaneLayer.contents = airplaneImage.cgImage
            airplaneLayer.bounds = CGRect(
                x: 0,
                y: 0,
                width: airplaneImage.size.width,
                height: airplaneImage.size.height)
            
            airplaneLayer.position = CGPoint(
                x: frame.size.width/2+frame.size.height/2*0.8,
                y: frame.size.height/2)
            
            layer.addSublayer(airplaneLayer)
            
            airplaneLayer.opacity = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RefreshView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = max(-(scrollView.contentOffset.y + scrollView.adjustedContentInset.top), 0.0)
        progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
        
        if !isRefreshing {
            redrawFromProgress(self.progress)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self)
            beginRefreshing()
            targetContentOffset.pointee.y = -scrollView.adjustedContentInset.top
        }
    }
    
    func beginRefreshing() {
        isRefreshing = true
        self.scrollView.contentInset.top = self.frame.height
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = 5.0
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = ovalShapeLayer.path
        flightAnimation.calculationMode = .paced
        
        let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        airplaneOrientationAnimation.fromValue = 0
        airplaneOrientationAnimation.toValue = 2.0 * .pi
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatDuration = 5.0
        flightAnimationGroup.animations = [
            flightAnimation,
            airplaneOrientationAnimation
        ]
        airplaneLayer.add(flightAnimationGroup, forKey: nil)
    }
    
    func endRefreshing() {
        isRefreshing = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0,
            options: .curveEaseOut, animations: {
                self.scrollView.contentInset.top = 0
            },
            completion: { _ in
                // finished
            })
    }
    
    func redrawFromProgress(_ progress: CGFloat) {
        ovalShapeLayer.strokeEnd = progress
        airplaneLayer.opacity = Float(progress)
    }
}
