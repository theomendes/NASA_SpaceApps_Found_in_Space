//
//  BoostBar.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

class BoostBar: SKSpriteNode {
    private var meter: SKSpriteNode
    
    init() {
        let eSize = CGSize(width: 247.15, height: 100.481)
        let energyLevelBackground = SKShapeNode(rectOf: CGSize(width: eSize.width,
                                                               height: eSize.height-20),
                                                    cornerRadius: 20)
        let border = SKShapeNode(rectOf: eSize, cornerRadius: 20)
        meter = SKSpriteNode(texture: nil, color: #colorLiteral(red: 0.5176470588, green: 0.9764705882, blue: 0.6470588235, alpha: 1), size: eSize)
        meter.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        border.fillColor = .clear
        border.strokeColor = #colorLiteral(red: 0.4706224799, green: 0.1552460492, blue: 0.5764831901, alpha: 1)
        border.lineWidth = 20
        border.zPosition = 3
        energyLevelBackground.addChild(border)
        
        super.init(texture: SKTexture(imageNamed: "plasmaBar"),
                   color: .clear,
                   size: CGSize(width: 403.063, height: 124.912))
        
        energyLevelBackground.fillColor = #colorLiteral(red: 0.6666666667, green: 0.2039215686, blue: 0.7921568627, alpha: 1)
        energyLevelBackground.strokeColor = .clear
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.zPosition = 1
        meter.zPosition = 2
        energyLevelBackground.zPosition = 1
        
        self.position = CGPoint(x: -170, y: 400)//y:450
        meter.position = CGPoint(x: absolutePosition(of: self).x + 50-meter.frame.size.width/2, y: absolutePosition(of: self).y)
        energyLevelBackground.position = CGPoint(x: absolutePosition(of: self).x + 50, y: absolutePosition(of: self).y)
        
        self.addChild(meter)
        self.addChild(energyLevelBackground)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
