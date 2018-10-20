//
//  Level.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

class Level: SKScene, SKPhysicsContactDelegate {
    var spaceship: Spaceship?
    var stars: [Star]?
    
    var finalPoint: CGPoint?
    var hasLaunched = false
    var pathNode: SKShapeNode!
    
    init(levelID: String, spaceship: Spaceship, stars: [Star], in view: UIView) {
        
        self.spaceship = spaceship
        self.stars = stars
        
        super.init(size: view.frame.size)
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(texture: SKTexture(imageNamed: levelID),
                                      color: UIColor.clear,
                                      size: view.frame.size)
        background.zPosition = -10
        addChild(background)
        
        addChild(spaceship)
        for star in stars {
            addChild(star)
        }
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint.zero
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        let zoomInAction = SKAction.scale(to: 0.9, duration: 0)
        cameraNode.run(zoomInAction)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //swiftlint:disable:next identifier_name
    func drawLine(to: CGPoint) {
        let myPath = CGMutablePath()
        
        let initialPos = (spaceship?.position)!
        
        myPath.move(to: initialPos)
        
        //        let unit = unitVector((spaceship?.position)!, finalPoint!)
        //        let dir = unit * 50
        //        myPath.addLine(to: translade(point: initialPos, by: dir))
        myPath.addLine(to: finalPoint!/70)
        if let node = pathNode {
            node.removeFromParent()
        }
        pathNode = SKShapeNode(path: myPath)
        
        let colorCoefficient = distance((spaceship?.position)!, finalPoint!) / 700
        pathNode.lineWidth = 2
        pathNode.fillColor = UIColor(red: colorCoefficient, green: 1-colorCoefficient, blue: 0, alpha: 1)
        pathNode.strokeColor = UIColor(red: colorCoefficient, green: 1-colorCoefficient, blue: 0, alpha: 1)
        addChild(pathNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasLaunched {
            for touch in touches {
                let location = touch.location(in: self)
                self.finalPoint = location
                drawLine(to: location)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasLaunched {
            for touch in touches {
                let location = touch.location(in: self)
                self.finalPoint = location
                pathNode.removeFromParent()
                drawLine(to: location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasLaunched {
            pathNode.removeFromParent()
            let velocity = CGVector.new(pointA: (spaceship?.position)!, pointB: finalPoint!)
            self.spaceship?.physicsBody?.isDynamic = true
            self.spaceship?.physicsBody?.velocity = velocity/5
            hasLaunched = true
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //swiftlint:disable start force_cast
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        //swiftlint:disable end
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")
        explosion?.particlePositionRange = CGVector(dx: 40, dy: 40)
        
        let death = SKAction.sequence([.fadeOut(withDuration: 0.3),
                                       .removeFromParent()])
        
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            firstNode.physicsBody?.isDynamic = false
            explosion?.position = firstNode.position
            addChild(explosion!)
            firstNode.run(death)
        } else {
            secondNode.physicsBody?.isDynamic = false
            explosion?.position = secondNode.position
            secondNode.addChild(explosion!)
            secondNode.run(death)
        }
    }
}

extension CGVector {
    static func new(pointA: CGPoint, pointB: CGPoint) -> CGVector {
        return CGVector(dx: pointB.x - pointA.x, dy: pointB.y - pointA.y)
    }
}

func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx/rhs, dy: lhs.dy/rhs)
}

func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x/rhs, y: lhs.y/rhs)
}

func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx*rhs, dy: lhs.dy*rhs)
}

func distance(_ pointA: CGPoint, _ pointB: CGPoint) -> CGFloat {
    return sqrt((pointA.x-pointB.x)*(pointA.x-pointB.x) + (pointA.y-pointB.y)*(pointA.y-pointB.y))
}

func unitVector(_ pointA: CGPoint, _ pointB: CGPoint) -> CGVector {
    return CGVector(dx: pointB.x - pointA.x, dy: pointB.y - pointA.y)/distance(pointA, pointB)
}

func translade(point: CGPoint, by: CGVector) -> CGPoint {
    return CGPoint(x: point.x + by.dx, y: point.y + by.dy)
}
