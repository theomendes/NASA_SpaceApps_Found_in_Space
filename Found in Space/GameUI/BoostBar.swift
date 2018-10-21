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
    
    init(position: CGPoint) {
//        let texture = SKTexture(imageNamed: <#T##String#>)
        meter = SKSpriteNode(texture: nil, color: UIColor.white, size: CGSize(width: 403.063, height: 124.912))
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.zPosition = 1
        meter.zPosition = 2
        
        self.position = position
        meter.position = CGPoint(x: absolutePosition(of: self).x + 50-meter.frame.size.width/2, y: absolutePosition(of: self).y)
        
        let maskbar = SKCropNode()
        maskbar.maskNode = SKSpriteNode(fileNamed: "fuelMask")
        maskbar.addChild(meter)
        
        self.addChild(maskbar)
        
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
