//
//  Description.swift
//  Found in Space
//
//  Created by Julia Rocha on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class Description:SKLabelNode {
    

    init(spaceship:GarageSpacecraft) {
        
        super.init(fontNamed: "Oxygen-Regular")
        self.text = spaceship.descriptionText
        self.fontSize = 30
        self.fontColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
