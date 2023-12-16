//
//  RefreshView.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit


class StrokeAndPathView: UIView {
    
    private let backgroundImage = UIImageView()
    
    private let ovalShapeLayer = CAShapeLayer()
    private let airPlaneLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
//        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 5
        ovalShapeLayer.lineDashPattern = [10, 2]
        
        let refreshRadius = frame.size.height/2*0.8
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(
            x: frame.size.width/2-refreshRadius,
            y: frame.size.height/2-refreshRadius,
            width: 2*refreshRadius,
            height: 2*refreshRadius)
        ).cgPath
        
        layer.addSublayer(ovalShapeLayer)
        
        let planeImage = UIImage(named: "plane")
        airPlaneLayer.contents = planeImage?.cgImage
            airPlaneLayer.bounds = CGRect(
                x: 0,
                y: 0,
                width: planeImage?.size.width ?? 10,
                height: (planeImage?.size.height) ?? 10
            )
            
            airPlaneLayer.position = CGPoint(
                x: frame.size.width/2 + frame.size.height/2 * 0.8,
                y: frame.size.height/2)
            
            layer.addSublayer(airPlaneLayer)
            airPlaneLayer.opacity = 1
        
        startAnimation()
    }
}

extension StrokeAndPathView {
    private func style() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "sky")
    }
    
    private func layout() {
        addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func startAnimation() {
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = .infinity
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
        flightAnimationGroup.repeatDuration = .infinity
        flightAnimationGroup.animations = [
            flightAnimation,
            airplaneOrientationAnimation
        ]
        airPlaneLayer.add(flightAnimationGroup, forKey: nil)
    }
}
