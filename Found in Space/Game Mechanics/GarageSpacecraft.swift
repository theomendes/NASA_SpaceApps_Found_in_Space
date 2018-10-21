//
//  GarageSpacecraft.swift
//  Found in Space
//
//  Created by Julia Rocha on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class GarageSpacecraft: SKSpriteNode {
    
    var descriptionText: String?
    
    init(name:String) {
        let texture = SKTexture(imageNamed: name)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.position = CGPoint(x: 0, y: 0)
        self.setScale(0.5)
        self.zRotation = -0.45
        
        switch name {
        case "mercury":
            //swiftlint:disable:next line_length
            self.descriptionText = "The first U.S. spaceship, the Atlas Spacecraft, used in the Mercury Project, was a cone-shaped one-man capsule with a cylinder mounted on top. Two meters (6 ft, 10 in) long, 1.9 meters (6 ft, 2 1/2 in) in diameter, a 5.8 meter (19 ft, 2 in) escape tower was fastened to the cylinder of the capsule. The blunt end was covered with an ablative heat shield to protect it against the 3,000 degree heat of entry into the atmosphere."
        case "shuttle":
            self.setScale(0.13)
            self.descriptionText = "test"
        case "dreamchaser":
            self.setScale(0.25)
            self.descriptionText = "test"
        default:
            self.descriptionText = "test"
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}
