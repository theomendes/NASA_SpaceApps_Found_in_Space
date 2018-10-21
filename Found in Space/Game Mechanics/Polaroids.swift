//
//  Polaroids.swift
//  Found in Space
//
//  Created by Julia Rocha on 21/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import Foundation
import SpriteKit

class Polaroids:SKSpriteNode {
    
    
    var catalogo = CatálogoFotos()
    
    init(level:Int, scene: SKScene, order:Int) {
        
        let molduraTexture = SKTexture(imageNamed: "polaroid")
        super.init(texture: molduraTexture, color: .clear, size: molduraTexture.size())
        switch order {
        case 2:
            self.position = CGPoint(x: 50, y: -40)
        default:
            self.position = CGPoint(x: -200, y: -40)
        }
        self.setScale(0.3)
        self.zPosition = 5
        
        let fixedSize = CGSize(width: 190, height: 190)
        
        let photoTexture = SKTexture(imageNamed: catalogo.catalogo[level - 1].photoID)
        let photo = SKSpriteNode(texture: photoTexture, color: .clear, size: photoTexture.size()) // photoTexture.size()
        photo.position = CGPoint(x: self.position.x, y: self.position.y + 20)
//        photo.scale(to: fixedSize)
        
        photo.setScale(0.26)
        photo.zPosition = 4
        scene.addChild(photo)
        
        let title = SKLabelNode(fontNamed: "Oxygen")
        title.text = catalogo.catalogo[level - 1].photoName
        title.fontSize = 14
        title.fontColor = UIColor.black
        title.position = CGPoint(x: self.position.x + 95, y: self.position.y - 85)
        title.zPosition = 6
        title.horizontalAlignmentMode = .right
        scene.addChild(title)
        
        let descrip = SKLabelNode(fontNamed: "Oxygen-Light")
        descrip.text = catalogo.catalogo[level - 1].photoDescription
        descrip.fontSize = 14
        descrip.fontColor = UIColor.black
        descrip.position = CGPoint(x: self.position.x + 95, y: self.position.y - 90)
        descrip.zPosition = 6
        descrip.numberOfLines = 0
        descrip.preferredMaxLayoutWidth = self.size.width - 15
        descrip.horizontalAlignmentMode = .right
        descrip.verticalAlignmentMode = .top
        scene.addChild(descrip)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
