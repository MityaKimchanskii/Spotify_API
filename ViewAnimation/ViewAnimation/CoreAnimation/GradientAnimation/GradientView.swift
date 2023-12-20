//
//  GradientView.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/18/23.
//

import UIKit
import CoreGraphics
import QuartzCore

class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    private let textAttributes: [NSAttributedString.Key: Any] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [.font: UIFont.systemFont(ofSize: 40, weight: .heavy), .paragraphStyle: style]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
//        style()
//        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayers()
        setupText()
        gradientAnimated()
    }
}

extension GradientView {
    private func setupLayers() {
        // Define endpoints
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        // Define colors
        let colors: [CGColor] = [ UIColor.black.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
        gradientLayer.colors = colors
        
        // Define locations
        let locations: [NSNumber] = [0.25, 0.5, 0.75]
        gradientLayer.locations = locations
        
        // Defin frame
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3*bounds.size.width,
            height: bounds.size.height)
        
        // Add sublayer
        layer.addSublayer(gradientLayer)
    }
    
    private func setupText() {
        let image = UIGraphicsImageRenderer(size: bounds.size).image { _ in
            "Hello World!".draw(in: bounds, withAttributes: textAttributes)
        }
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
        maskLayer.contents = image.cgImage
        
        gradientLayer.mask = maskLayer
    }
    
    private func gradientAnimated() {
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0, 0, 0.25]
        gradientAnimation.toValue = [0.75, 1, 1]
        gradientAnimation.duration = 5
        gradientAnimation.repeatCount = Float.infinity
        
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
}
