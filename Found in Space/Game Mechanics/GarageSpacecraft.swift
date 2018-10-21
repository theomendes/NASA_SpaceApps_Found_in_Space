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
    
    init(name: String) {
        let texture = SKTexture(imageNamed: name)
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.position = CGPoint(x: -100, y: 0)
        self.setScale(0.5)
        self.zRotation = -0.45
        
        switch name {
        case "mercury":
            self.setScale(0.3)
            //swiftlint:disable:next line_length
            self.descriptionText = "The first U.S. spaceship, the Atlas Spacecraft, used in the Mercury Project, was a cone-shaped one-man capsule with a cylinder mounted on top. The end of the spacecraft was covered with an ablative heat shield to protect it against the 3,000 degree heat of entry into the atmosphere."
            
        case "apollo":
            self.setScale(0.35)
            //swiftlint:disable:next line_length
            self.descriptionText = "The Apollo was a three-part spacecraft: the command module (CM), the crew's quarters and flight control section; the service module (SM) for the propulsion and spacecraft support systems (when together, the two modules are called CSM); and the lunar module (LM)."
            
        case "shuttle":
            self.setScale(0.11)
            self.zRotation = -0.6

//            self.position = CGPoint(x: self.position.x, y: self.position.y - 20)
            //swiftlint:disable:next line_length
            self.descriptionText = "With two solid rocket boosters, this spacecraft was named after a ship chartered to traverse the South Pacific in 1768 and captained by 18th century British explorer James Cook. One of the major mission of this space shuttle was the first service mission to the Hubble Space Telescope, which took place in December 1993."
            
        case "dreamchaser":
            self.setScale(0.2)
            //swiftlint:disable:next line_length
            self.descriptionText = "The Dream Chaser is undergoing final preparations at NASA Langley. The lifting body reusable spacecraft would carry as many as seven astronauts to the space station. Check out the spacecraft as it approaches the speed of sound in a test drive mission."
        default:
            self.descriptionText = "Erro na descrição."
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
