//
//  Planet.swift
//  WWDC2018
//
//  Created by pedro ferraz on 19/03/18.
//  Copyright © 2018 pedro ferraz. All rights reserved.
//

import Foundation
import SpriteKit

public class Planet: SKSpriteNode {
    var radius: CGFloat
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
    
    public init(planetTextureName: String, position: CGPoint, velocity: CGVector, radius: CGFloat, angularVelocity: CGFloat = 0) {
        self.radius = radius
        
        var gravityField: SKFieldNode {
            let gf = SKFieldNode.radialGravityField()
            gf.strength = Float(pow(self.radius, 2)) * pow(10, -2)
            gf.categoryBitMask = planetGravityCategory
            gf.isEnabled = true;
            //            gf.region = SKRegion(radius: Float(CGFloat(self.radius)))
            return gf
        }
        
        let image = SKTexture(imageNamed: planetTextureName)
        let scale = 2 * radius / image.size().width
        
        super.init(texture: image, color: UIColor.green, size: image.size())
        
        self.setScale(scale)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.radius)
        
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        
        self.position = position
        self.zPosition = 1
        self.physicsBody?.velocity = velocity
        self.physicsBody?.angularVelocity = angularVelocity
        
        self.physicsBody?.fieldBitMask = starGravityCategory //É atraído por estrelas
        self.physicsBody?.categoryBitMask = planetBodyCategory //É da categoria planeta
        self.physicsBody?.collisionBitMask = 0 //starBodyCategory //Colide com estrelas
        self.physicsBody?.contactTestBitMask = starBodyCategory
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.isDynamic = true
        
        self.addChild(gravityField)
    }
    
    
}


