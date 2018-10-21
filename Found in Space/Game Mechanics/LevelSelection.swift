//
//  GameScene.swift
//  nasaprototipo
//
//  Created by Mariana Clemente on 20/10/18.
//  Copyright © 2018 Mariana Clemente. All rights reserved.
//

import SpriteKit
import  AVFoundation

class LevelSelection: SKScene {
    let background = SKSpriteNode(imageNamed: "stageBg")
    let imageLevel1: String = "stage1"
    let imageLevel2: String = "stage2"
    let imageLevel3: String = "stage3"
  
    var title = SKLabelNode()
    var imageBack: String = "arrowLeft"
    var audioplayer = AVAudioPlayer()
    var controller: GameViewController? 
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var back: Button = {
        var button = Button(imageNamed: imageBack, completion: setupBack)
        button.zPosition = 10
        button.position = CGPoint(x: self.size.width * 0.08, y: self.size.height * 0.9)
        button.setScale(0.3)
        
        
        return button
    }()
    
    lazy var level1: Button = {
        var button = Button(imageNamed: imageLevel2, completion: setupLevel2, label: "Proxima Centauri")

        button.zPosition = 10
        button.position = CGPoint(x: self.size.width * 0.24, y: self.size.height * 0.62)
        
        return button
    }()
    
    lazy var level2: Button = {
        var button = Button(imageNamed: imageLevel1, completion: setupLevel1, label: "IRAS 14348-1447")
        button.zPosition = 10
        button.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.62)
        button.alpha = 0.5
        
        return button
    }()
    
    lazy var level3: Button = {
        var buttonn = Button(imageNamed: imageLevel3, completion: setupLevel3, label: "V838 Monocerotis")
        buttonn.zPosition = 10
        buttonn.position = CGPoint(x: self.size.width * 0.76, y: self.size.height * 0.62)
        buttonn.alpha = 0.5

        
        return buttonn
    }()

    
    func setupLevel1 () -> Void {
        controller?.present(index: 1)
    }
    
    func setupLevel2 () -> Void {
        controller?.present(index: 0)
    }
    
    func setupLevel3 () -> Void {
        controller?.present(index: 2)
    }
    
    func setupBack () -> Void{
//        let scene = GameScene2(size: (self.view?.bounds.size)!)
//        self.view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 2.0))
    }

    override func didMove(to view: SKView) {
   
        background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        background.zPosition = -10
        background.size = CGSize(width: self.size.width, height: self.size.height)
        
        title = SKLabelNode(text: "Choose a stage")
        title.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.9)
        title.zPosition = 10
        title.fontName = "Oxygen-Bold"
        //        labell.frame = CGRect(
        title.fontSize = 20
        addChild(title)
        
        addChild(background)
        addChild(level1)
        addChild(level2)
        addChild(level3)
        addChild(back)
   
    }
}
