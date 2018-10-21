//
//  DoneButton.swift
//  Found in Space
//
//  Created by Julia Rocha on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class DoneButton:SKSpriteNode {
    
    init() {
        let texture = SKTexture.init(imageNamed: "continue")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = 5
        self.position = CGPoint(x: 255, y: -120)
        self.setScale(0.4)
        
        let lblNode = SKLabelNode(fontNamed: "Oxygen")
        self.addChild(lblNode)
        lblNode.text = "Continue"
        lblNode.fontSize = 40
        lblNode.fontColor = UIColor.white
        lblNode.position = CGPoint(x: 0, y: -130)
        lblNode.zPosition = 5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
