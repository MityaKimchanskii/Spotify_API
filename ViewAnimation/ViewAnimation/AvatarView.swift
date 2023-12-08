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
    private let circleLayer = CAShapeLayer()
    private let maskLayer = CAShapeLayer()
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = .red
        
        return label
    }()
    
    
    @IBInspectable var image: UIImage? {
        didSet {
            photoLayer.contents = image?.cgImage
        }
    }
    
    @GKInspectable var name: String? {
        didSet {
            label.text = name
        }
    }
    
    var shouldTransitionToFinishedState = false
    
    override func didMoveToWindow() {
        layer.addSublayer(photoLayer)
        photoLayer.mask = maskLayer
        layer.addSublayer(maskLayer)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        guard let image = image else { return }
        
        photoLayer.frame = CGRect(
            x: (bounds.size.width-image.size.width+lineWidth)/2,
            y: (bounds.size.height-image.size.height)/2, 
            width: image.size.width,
            height: image.size.height
        )
        
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0, y: 10)
        
        label.frame = CGRect(x: 0, y: bounds.size.height+10, width: bounds.size.width, height: 24)
    }
}

extension AvatarView {
    private func style() {
        
    }
    
    private func layout() {
        
    }
}
