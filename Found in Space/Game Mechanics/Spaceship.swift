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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        spaceshipTextureName: String,
        position: CGPoint,
        velocity: CGVector,
        radius: CGFloat,
        angularVelocity: CGFloat = 0) {
        self.radius = radius
        
        var gravityField: SKFieldNode {
            let grf = SKFieldNode.radialGravityField()
            grf.strength = Float(pow(radius, 2)) * pow(10, -2)
            grf.categoryBitMask = Constants.spaceshipGravityCategory
            grf.isEnabled = true
            return grf
        }
        
        let image = SKTexture(imageNamed: spaceshipTextureName)
        let scale = 2 * radius / image.size().width
        
        super.init(texture: image, color: UIColor.green, size: image.size())
        
        setScale(scale)
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        physicsBody?.friction = 0.2
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        
        self.position = position
        zPosition = 1
        physicsBody?.velocity = velocity
        physicsBody?.angularVelocity = angularVelocity
        
        physicsBody?.fieldBitMask = Constants.starGravityCategory //É atraído por estrelas
        physicsBody?.categoryBitMask = Constants.spaceshipBodyCategory //É da categoria planeta
        physicsBody?.collisionBitMask = 0 //starBodyCategory //Colide com estrelas
        physicsBody?.contactTestBitMask = Constants.starBodyCategory
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.isDynamic = true
        
        addChild(gravityField)
    }

}
