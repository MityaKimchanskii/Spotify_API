//
//  EmittersViewController.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/22/23.
//

import UIKit


class EmittersViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        createEmitterLayer()
    }
}

extension EmittersViewController {
    private func style() {
        view.backgroundColor = .white
    }
    
    private func createEmitterLayer() {
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = rect
        view.layer.addSublayer(emitterLayer)
        
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitterLayer.emitterSize = rect.size
        
        let emitterCell = CAEmitterCell()
    
//        emitterCell.contents = UIImage(named: "balloon")?.cgImage
        emitterCell.contents = UIImage(named: "balloon")?.cgImage
//        emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
//        emitterCell.greenRange = 0.3
//        emitterCell.redRange = 0.3
//        emitterCell.blueRange = 0.3
        emitterCell.birthRate = 3
        emitterCell.lifetime = 3.5
        emitterCell.yAcceleration = 70
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
//        emitterCell.xAcceleration = 50
        emitterCell.velocityRange = 200
        emitterCell.velocity = 20
        emitterCell.emissionLongitude = .pi * -0.5
        emitterLayer.emitterCells = [emitterCell]
    }
}
