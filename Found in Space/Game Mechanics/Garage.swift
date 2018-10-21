//
//  Garage.swift
//  Found in Space
//
//  Created by Julia Rocha on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class Garage: SKScene {
    
    var currentSpacecraft:Spaceship?

    
    init(avalableSpaceships:[Spaceship], in view: UIView) {
        super.init(size: view.frame.size)
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.currentSpacecraft = avalableSpaceships[0]
        addChild(currentSpacecraft!)
        
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > 0 {
                print("Go left")
            }
            else {
                print("Go right")
            }
        }
    }

}
