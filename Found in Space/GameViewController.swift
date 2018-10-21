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
    let levelsData = DataAccess.object.loadLevels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.skview = SKView(frame: self.view.bounds)
        self.view.addSubview(skview!)
        
        if let view = skview {
            let level = Level(from: levelsData[1], in: self.view)
            view.presentScene(level)
            
            view.ignoresSiblingOrder = true
//            view.showsFields = true
//            view.showsPhysics = true
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
