//
//  Star.swift
//  WWDC2018
//
//  Created by pedro ferraz on 19/03/18.
//  Copyright © 2018 pedro ferraz. All rights reserved.
//

import Foundation
import SpriteKit

public class Star: SKSpriteNode {
    var radius: CGFloat
    var strength: Float
    let starGravityCategory: UInt32 = 0x1 << 0
    let planetGravityCategory: UInt32 = 0x1 << 1
    let satelliteGravityCategory: UInt32 = 0x1 << 2
    let starBodyCategory: UInt32 = 0x1 << 3
    let planetBodyCategory: UInt32 = 0x1 << 4
    let satelliteBodyCategory: UInt32 = 0x1 << 5
    let astronautBodyCategoty: UInt32 = 0x1 << 6
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gravityField: SKFieldNode {
        let gf = SKFieldNode.radialGravityField()
        gf.strength = Float(pow(self.radius, 2)) * self.strength
        gf.categoryBitMask = starGravityCategory
        gf.isEnabled = true;
        return gf
    }
    
    public init(starTextureName: String, radius: CGFloat, position: CGPoint = CGPoint(x: 0, y: 0), strength: Float = 0.001, diameterRatio: CGFloat = 3, angularVelocity: CGFloat = 0) {
        self.radius = radius
        self.strength = strength
        
        let image = SKTexture(imageNamed: starTextureName)
        let scale = diameterRatio * radius / image.size().width
        
        super.init(texture: image, color: UIColor.red, size: image.size())

        
        self.setScale(scale)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.radius)
        self.position = position
        self.physicsBody?.angularVelocity = angularVelocity
        
        self.physicsBody?.fieldBitMask = 0
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = starBodyCategory //É da categoria estrela
        self.physicsBody?.contactTestBitMask = planetBodyCategory
        
        physicsBody?.isDynamic = true
        
        self.addChild(gravityField)
    }
    
}

