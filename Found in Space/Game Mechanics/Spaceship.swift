//
//  Planet.swift
//  WWDC2018
//
//  Created by pedro ferraz on 19/03/18.
//  Copyright © 2018 pedro ferraz. All rights reserved.
//

import SpriteKit

class Spaceship: SKSpriteNode {
    var radius: CGFloat
    var oldPosition: CGPoint
    
    
    init(
        spaceshipTextureName: String,
        position: CGPoint,
        radius: CGFloat) {
        self.radius = radius
        self.oldPosition = position
        
        
        var gravityField: SKFieldNode {
            let grf = SKFieldNode.radialGravityField()
            grf.strength = Float(pow(radius, 2)) * pow(10, -2)
            grf.categoryBitMask = Constants.spaceshipGravityCategory
            grf.isEnabled = true
            return grf
        }
        
        let image = SKTexture(imageNamed: spaceshipTextureName)
        let scale = 3 * radius / image.size().width
        
        super.init(texture: image, color: UIColor.green, size: image.size())
        
        setScale(scale)
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        physicsBody?.friction = 0.2
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.position = position
        zPosition = 1
        
        physicsBody?.fieldBitMask = Constants.starGravityCategory
        physicsBody?.categoryBitMask = Constants.spaceshipBodyCategory
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = Constants.starBodyCategory
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.isDynamic = false
        
        addChild(gravityField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
