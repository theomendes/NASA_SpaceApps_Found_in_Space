//
//  BoostBar.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

class BoostBar: SKCropNode {
    private var meter: SKSpriteNode
    private var mask: SKSpriteNode
    private var boostMax = 3
    private var actualBoost = 0
    var boostable = true
    
    init(position: CGPoint) {
        let maskTexture = SKTexture(imageNamed: "fuelMask")
        mask = SKSpriteNode(texture: maskTexture, color: UIColor.white, size: maskTexture.size())
        mask.xScale = 0.3
        mask.yScale = 0.3
        
        let meterTexture = SKTexture(imageNamed: "fuelCharge")
        meter = SKSpriteNode(texture: nil, color: UIColor.white, size: mask.size)
        meter.color = .green
        meter.anchorPoint = CGPoint(x: 0, y: 0.5)
        meter.position.x = mask.position.x - mask.size.width/2
        
        super.init()
        
        self.position = position
        
        self.maskNode = mask
        self.addChild(meter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateDecrease() -> SKAction {
        let decrease = SKAction.scaleX(to: CGFloat(boostMax-actualBoost) / CGFloat(boostMax), duration: 0.5)
        
        let color = UIColor(red: CGFloat(actualBoost)/CGFloat(boostMax),
                            green: 1-CGFloat(actualBoost)/CGFloat(boostMax),
                            blue: 0,
                            alpha: 1)
        let animatecolor = SKAction.colorize(with: color, colorBlendFactor: 1, duration: 0.3)
        
        let animate = SKAction.group([decrease, animatecolor])
        return animate
    }
    
    func decreaseEnergy() {
        if actualBoost < boostMax {
            actualBoost += 1
            self.meter.run(animateDecrease())
        } else {
            boostable = false
        }
    }
    
    func refill() {
        self.actualBoost = 0
        self.boostable = true
        let action = SKAction.group([SKAction.scaleX(to: 1, duration: 0.2),
                                        SKAction.colorize(with: UIColor.green,
                                                          colorBlendFactor: 1,
                                                          duration: 0.2)])
        let sequence = SKAction.sequence([action, SKAction.run { self.meter.color = .green }])
    
        self.meter.run(sequence)
    }
    
}

extension SKNode {
    func absolutePosition(of childNode: SKNode) -> CGPoint {
        guard let parent = childNode.parent else {return CGPoint.zero}
        if parent == self {
            return childNode.position
        } else {
            return parent.absolutePosition(of: parent) + childNode.position
        }
    }
}
