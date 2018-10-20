//
//  Level.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

class Star: SKSpriteNode {
    var radius: CGFloat
    var strength: Float
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gravityField: SKFieldNode {
        let grf = SKFieldNode.radialGravityField()
        grf.strength = Float(pow(radius, 2)) * strength
        grf.categoryBitMask = Constants.starGravityCategory
        grf.isEnabled = true
        return grf
    }
    
    public init(radius: CGFloat,
                position: CGPoint = CGPoint(x: 0, y: 0),
                strength: Float = 0.001,
                diameter: CGFloat = 3,
                angularVelocity: CGFloat = 0) {
        self.radius = radius
        self.strength = strength
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: diameter, height: diameter))
        
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.position = position
        physicsBody?.angularVelocity = angularVelocity
        
        physicsBody?.fieldBitMask = 0
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = Constants.starBodyCategory
        physicsBody?.contactTestBitMask = Constants.spaceshipBodyCategory
        
        physicsBody?.isDynamic = true
        
        addChild(gravityField)
    }
    
}
