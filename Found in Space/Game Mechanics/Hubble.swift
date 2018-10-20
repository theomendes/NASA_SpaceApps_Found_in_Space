//
//  Hubble.swift
//  Found in Space
//
//  Created by Julia Rocha on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class Hubble: SKSpriteNode {
    var radius: CGFloat
    var strength: Float
    
    var gravityField: SKFieldNode {
        let grf = SKFieldNode.radialGravityField()
        grf.strength = Float(pow(radius, 2)) * strength
        grf.categoryBitMask = Constants.hubbleBodyCategory
        grf.isEnabled = true
        return grf
    }
   
    init(radius: CGFloat,
         position: CGPoint = CGPoint(x: 270, y: 0),
         strength: Float = 0.001,
         diameter: CGFloat = 20,
         angularVelocity: CGFloat = 0) {
        
        let image = SKTexture(imageNamed: "hubble")
        let scale =  radius / image.size().width
        
        self.radius = radius
        self.strength = strength
        
        super.init(texture: image, color: .clear, size: image.size())
                
        self.setScale(scale)
        self.position = position
        
        physicsBody = SKPhysicsBody(circleOfRadius: diameter)
        self.position = position
        physicsBody?.angularVelocity = angularVelocity
        
        physicsBody?.fieldBitMask = 0
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = Constants.hubbleBodyCategory
        physicsBody?.contactTestBitMask = Constants.spaceshipBodyCategory
        
        physicsBody?.isDynamic = true
        
        addChild(gravityField)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
