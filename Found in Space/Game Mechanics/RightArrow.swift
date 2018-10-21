//
//  RightArrow.swift
//  Found in Space
//
//  Created by Julia Rocha on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import Foundation
import SpriteKit

class RightArrow:SKSpriteNode {
    
    init() {
        let texture = SKTexture.init(imageNamed: "arrowRight")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = 5
        self.position = CGPoint(x: 260, y: -120)
        self.setScale(0.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
