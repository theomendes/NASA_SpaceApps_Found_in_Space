//
//  Level.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

class Level: SKScene, SKPhysicsContactDelegate {
    var spaceship: Spaceship?
    var stars: [Star]?
    
    init(levelID: String, spaceship: Spaceship, stars: [Star], in view: UIView) {
        self.spaceship = spaceship
        self.stars = stars
        
        super.init(size: view.frame.size)
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: levelID),
                                      color: UIColor.clear,
                                      size: view.frame.size)
        background.zPosition = -10
        addChild(background)
        
        addChild(spaceship)
        for star in stars {
            addChild(star)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
