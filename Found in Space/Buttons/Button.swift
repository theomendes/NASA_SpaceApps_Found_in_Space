//
//  Button.swift
//  nasaprototipo
//
//  Created by Mariana Clemente on 20/10/18.
//  Copyright © 2018 Mariana Clemente. All rights reserved.
//

import SpriteKit

class Button: SKNode{
    var button: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode: SKCropNode
    private var action: () -> Void
    var labell: SKLabelNode
    var image: SKTexture
    var isEnable = true
    
    init(imageNamed: String, buuu: @escaping () -> Void, label: String? = nil){
        image = SKTexture(imageNamed: imageNamed)
        button = SKSpriteNode(texture: image)
     
        mask = SKSpriteNode(color: SKColor.black, size: button.size)
        mask.alpha = 0
        
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.addChild(mask)
        
        action = buuu
        
        labell = SKLabelNode(text: label)
        labell.position = CGPoint(x: button.position.x, y: button.position.y - button.size.height/2 - labell.fontSize * 0.75)
        labell.zPosition = button.zPosition
        labell.fontName = "Oxygen-Bold"
        labell.fontSize = 18
        super.init()
        
        isUserInteractionEnabled = true
        
        setupNodes()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes(){
        button.zPosition = 0
        cropNode.zPosition = 3
    }
    
    func addNodes() {
        addChild(labell)
        addChild(button)
        addChild(cropNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable{
            mask.alpha = 0.5
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable{
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location){
                    mask.alpha = 0.5
                } else {
                    mask.alpha = 0.0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable{
            for touch in touches{
                let location: CGPoint = touch.location(in: self)
                            
                if button.contains(location){
                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run({
                        self.enable()
                    })]))
                }
            }
        }
    }
   
    func disable(){
        isEnable = false
        mask.alpha = 0.0
        button.alpha = 0.5
    }
    
    func enable(){
        isEnable = true
        mask.alpha = 0.0
        button.alpha = 1.0
    }
}
