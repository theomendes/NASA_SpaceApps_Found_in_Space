//
//  Level.swift
//  Found in Space
//
//  Created by pedro ferraz on 20/10/18.
//  Copyright © 2018 NASA Space Apps 2018. All rights reserved.
//

import SpriteKit

class Level: SKScene, SKPhysicsContactDelegate {
    
    var hasChosen = false
    
    var spaceship: Spaceship?
    var stars: [Star]?
    
    var initialPosition: CGPoint
    var finalPoint: CGPoint?
    var hasLaunched = false
    var pathNode: SKShapeNode!
    
    let boundMax: CGFloat!
    
    var playing = true
    let loseDelay = 0.3
    
    init(levelID: String, spaceship: Spaceship, stars: [Star], in view: UIView) {
        
        self.spaceship = spaceship
        self.stars = stars
        self.initialPosition = spaceship.position
        
        let hubble = Hubble(radius: 50,
                            position: CGPoint(x: 270, y: 0),
                            strength: 0.001,
                            angularVelocity: 0)
        
        boundMax = view.bounds.width/2
        
        boostBar = BoostBar(position: CGPoint(x: -150, y: 130))
        
        super.init(size: view.frame.size)
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        let bgTexture = SKTexture(imageNamed: levelID)
        let background = SKSpriteNode(texture: bgTexture,
                                      color: UIColor.clear,
                                      size: view.frame.size)
        background.zPosition = -10
        addChild(background)
        
        addChild(spaceship)
        
        addChild(hubble)
        
        for star in stars {
            addChild(star)
        }
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint.zero
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        let zoomInAction = SKAction.scale(to: 0.9, duration: 0)
        cameraNode.run(zoomInAction)
        
        let backgroundTexture = SKTexture(imageNamed: "fuelBar")
        let barBackground = SKSpriteNode(texture: backgroundTexture,
                                         color: UIColor.white,
                                         size: backgroundTexture.size())
        barBackground.xScale = 0.3
        barBackground.yScale = 0.3
        barBackground.position = boostBar.position
        barBackground.zPosition = boostBar.zPosition - 1
        self.addChild(boostBar)
        self.addChild(barBackground)
    }
    
    convenience init?(from data: LevelData, in view: UIView) {
        let levelID = data.levelID
        let spaceship = Spaceship(spaceshipTextureName: Constants.shipTextures[data.spaceship.index],
                                  position: CGPoint(x: data.spaceship.position[0],
                                                    y: data.spaceship.position[1]),
                                  radius: CGFloat(data.spaceship.radius))
        
        var stars: [Star] = []
        //swiftlint:disable:next identifier_name
        for i in 0..<data.stars.count {
            let star = Star(radius: CGFloat(data.stars[i].radius),
                            position: CGPoint(x: data.stars[i].position[0],
                                              y: data.stars[i].position[1]),
                            strength: data.stars[i].strength,
                            diameter: CGFloat(data.stars[i].diameter))
            stars.append(star)
        }
        self.init(levelID: levelID,
                  spaceship: spaceship,
                  stars: stars,
                  in: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //swiftlint:disable:next identifier_name
    func drawLine(to: CGPoint) {
        let myPath = CGMutablePath()
        
        let initialPos = (spaceship?.position)!
        
        myPath.move(to: initialPos)
        
        let colorCoefficient = distance((spaceship?.position)!, finalPoint!) / 700
        
        let unit = unitVector((spaceship?.position)!, finalPoint!)
        let dir = unit * (20 + 100 * colorCoefficient)
        myPath.addLine(to: translade(point: initialPos, by: dir))
        
        if dir.dx > 0 {
            self.spaceship?.zRotation = atan(dir.dy/dir.dx) - CGFloat.pi/2
        } else {
            self.spaceship?.zRotation = atan(dir.dy/dir.dx) + CGFloat.pi/2
        }
        
        if let node = pathNode {
            node.removeFromParent()
        }
        pathNode = SKShapeNode(path: myPath)
        
        pathNode.lineWidth = 2
        pathNode.fillColor = UIColor(red: colorCoefficient, green: 1-colorCoefficient, blue: 0, alpha: 1)
        pathNode.strokeColor = UIColor(red: colorCoefficient, green: 1-colorCoefficient, blue: 0, alpha: 1)
        addChild(pathNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            
            let location = touch.location(in: self)
            if !hasLaunched && playing {
                self.finalPoint = location
                drawLine(to: location)
            } else if boostBar.boostable {
                var direction = CGVector.new(pointA: (self.spaceship?.position)!, pointB: location)
                direction = direction.normalized()
                self.spaceship?.physicsBody?.applyImpulse(direction / 3)
                boostBar.decreaseEnergy()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasLaunched && playing {
            for touch in touches {
                let location = touch.location(in: self)
                self.finalPoint = location
                pathNode.removeFromParent()
                drawLine(to: location)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasLaunched && playing {
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
        explosion?.particlePositionRange = CGVector(dx: 20, dy: 20)
        
        let death = SKAction.sequence([.fadeOut(withDuration: loseDelay),
                                       .removeFromParent()])
        
        if contact.bodyA.categoryBitMask == Constants.hubbleBodyCategory || contact.bodyB.categoryBitMask == Constants.hubbleBodyCategory {
            print("yay")
        } else if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            firstNode.physicsBody?.isDynamic = false
            explosion?.position = firstNode.position
            addChild(explosion!)
            firstNode.run(death)
            self.reset()
        } else {
            secondNode.physicsBody?.isDynamic = false
            explosion?.position = secondNode.position
            secondNode.addChild(explosion!)
            secondNode.run(death)
            self.reset()
        }
    }
    
    func reset() {
        self.hasLaunched = false
        self.playing = false
        let lostScreen = SKSpriteNode(color: UIColor.black, size: self.size)
        lostScreen.alpha = 0
        lostScreen.zPosition = 3
        let lostAction = SKAction.sequence([.fadeIn(withDuration: 0.1),
                                            .fadeOut(withDuration: 0.1),
                                            .removeFromParent()])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + loseDelay, execute: {
            self.addChild(lostScreen)
            lostScreen.run(lostAction)
            self.boostBar.refill()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + loseDelay + 0.2, execute: {
            self.spaceship?.removeFromParent()
            self.spaceship?.removeAllActions()
            self.spaceship?.alpha = 1
            self.spaceship?.position = self.initialPosition
            self.spaceship?.physicsBody?.isDynamic = false
            self.addChild(self.spaceship!)
            self.playing = true
        })
    }
    
    override func update(_ currentTime: TimeInterval) {
        if distance(CGPoint.zero, (spaceship?.position)!) > boundMax {
            reset()
        }
        
        if hasLaunched {
            let xvel = (self.spaceship?.physicsBody?.velocity.dx)!
            let yvel = (self.spaceship?.physicsBody?.velocity.dy)!
            if xvel > 0 {
                self.spaceship?.zRotation = atan(yvel/xvel) - CGFloat.pi/2
            } else {
                self.spaceship?.zRotation = atan(yvel/xvel) + CGFloat.pi/2
            }
        }
        
    }
    
    
    
    func displaySpaceshipChoice() {
        
    }
    
    func displayGame() {
        
    }
}
