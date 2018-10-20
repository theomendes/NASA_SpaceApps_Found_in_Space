//
//  ViewController.swift
//  Found in Space
//
//  Created by Theo Mendes on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var skview: SKView?
    var gameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var stars: [Star] = []
        
        let star0 = Star(radius: 100,
                        position: CGPoint(x: -105, y: -12),
                        strength: 0.00001,
                        diameter: 20,
                        angularVelocity: 0)
        
        let star1 = Star(radius: 50,
                         position: CGPoint(x: 140, y: 75),
                         strength: 0.0001,
                         diameter: 30,
                         angularVelocity: 0)
        
        let star2 = Star(radius: 50,
                         position: CGPoint(x: 110, y: -60),
                         strength: 0.0001,
                         diameter: 20,
                         angularVelocity: 0)
        
        stars.append(star0)
        stars.append(star1)
        stars.append(star2)
        
        let spaceship = Spaceship(spaceshipTextureName: "spaceship",
                                  position: CGPoint(x: -265, y: -120),
                                  velocity: CGVector(dx: 10, dy: 50),
                                  radius: 5)
        
        self.skview = SKView(frame: self.view.bounds)
        self.view.addSubview(skview!)
        
        if let view = skview {
            let level = Level(levelID: "level1", spaceship: spaceship, stars: stars, in: self.view)
            view.presentScene(level)
            
            view.ignoresSiblingOrder = true
            view.showsFields = false
            view.showsPhysics = false
            setNeedsFocusUpdate()
        }
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}
