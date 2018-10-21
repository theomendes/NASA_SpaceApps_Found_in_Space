//
//  Victory.swift
//  Found in Space
//
//  Created by Julia Rocha on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class Victory: SKScene {
    
    var score: Int
    var theView: UIView
    var level: Int
    var controller: GameViewController?

    init(levelWon: Int, score: Int, in view: UIView) {
        self.theView = view
        self.score = score
        self.level = levelWon
        super.init(size: view.frame.size)
        self.backgroundColor = .black
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        displayElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayElements() {
        let backgroundTexture = SKTexture(imageNamed: "homeBackground")
        let background = SKSpriteNode(texture: backgroundTexture, color: .clear, size: self.theView.frame.size)
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)
        
        let labelNode = SKLabelNode(fontNamed: "Oxygen")
        self.addChild(labelNode)
        labelNode.text = "You repaired the Hubble! Two new pictures recovered!"
        labelNode.fontSize = 18.5
        labelNode.fontColor = UIColor.white
        labelNode.position = CGPoint(x: -310, y: 150)
        labelNode.numberOfLines = 0
        labelNode.verticalAlignmentMode = .top
        labelNode.horizontalAlignmentMode = .left
        labelNode.zPosition = 5
        
        let scoreLblNode = SKLabelNode(fontNamed: "Oxygen")
        self.addChild(scoreLblNode)
        scoreLblNode.text = "Your score"
        scoreLblNode.preferredMaxLayoutWidth = 250
        scoreLblNode.fontSize = 21
        scoreLblNode.fontColor = UIColor.white
        scoreLblNode.position = CGPoint(x: 260, y: 100)
        scoreLblNode.zPosition = 5
        
        let highScoreLblNode = SKLabelNode(fontNamed: "Oxygen")
//        self.addChild(highScoreLblNode)
        highScoreLblNode.text = "High score"
        highScoreLblNode.preferredMaxLayoutWidth = 250
        highScoreLblNode.fontSize = 21
        highScoreLblNode.fontColor = UIColor.white
        highScoreLblNode.position = CGPoint(x: 260, y: 10)
        highScoreLblNode.zPosition = 5
        
        let done = DoneButton()
        self.addChild(done)
        
        scoreLabels(score: score, high: false)
        
        let polaroid1 = Polaroids(level: level, scene: self, order: 1)
        addChild(polaroid1)
        
        let polaroid2 = Polaroids(level: level + 1, scene: self, order: 2)
        addChild(polaroid2)
    }
    
    func scoreLabels(score: Int, high: Bool) {
        let lbl = SKLabelNode(fontNamed: "Oxygen-Light")
        lbl.text = String(score)
        lbl.fontSize = 20
        lbl.fontColor = UIColor.white
        lbl.position = CGPoint(x: 260, y: 75)
        lbl.zPosition = 5
        if high {
            lbl.position = CGPoint(x: 260, y: -15)
        }
        addChild(lbl)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if let done = touchedNode as? DoneButton {
                //Go to levels
                self.controller?.gotoSelection()
            }
            
        }
    }
}
