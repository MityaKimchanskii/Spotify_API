//
//  GameScene.swift
//  ZombieConga
//
//  Created by Dmitrii Kim on 12/30/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let car = SKSpriteNode(imageNamed: "car")
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480
    var velocity = CGPoint.zero
 
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = CGSize(width: size.width, height: size.height)
//        background.zRotation = CGFloat(M_PI)/8
        background.zPosition = -1
        addChild(background)
        
        car.position = CGPoint(x: 0, y: 500)
        car.size = CGSize(width: 470, height: 400)
        addChild(car)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        move(sprite: car, velocity: CGPoint(x: zombieMovePointsPerSec, y: 0))
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = CGPoint(x: velocity.x*CGFloat(dt), y: velocity.y*CGFloat(dt))
        print("Amount to move: \(amountToMove)")
        
        sprite.position = CGPoint(x: sprite.position.x+amountToMove.x, y: sprite.position.y+amountToMove.y)
    }
    
    func moveZombieToward(location: CGPoint) {
        let offset = CGPoint(x: location.x - car.position.x, y: location.y - car.position.y)
        let lenght = sqrt(Double(offset.x*offset.x+offset.y*offset.y))
        let direction = CGPoint(x: offset.x/CGFloat(lenght), y: offset.y/CGFloat(lenght))
        velocity = CGPoint(x: direction.x*zombieMovePointsPerSec, y: direction.y*zombieMovePointsPerSec)
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        moveZombieToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
}
