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
    var boostBar: BoostBar
    var levelID: String
    var labelNode = SKLabelNode(fontNamed: "Oxygen")
    var titleNode = SKLabelNode(fontNamed: "Oxygen")
    
    var initialPosition: CGPoint
    var finalPoint: CGPoint?
    var hasLaunched = false
    var pathNode: SKShapeNode!
    
    let boundMax: CGFloat!
    
    var playing = true
    let loseDelay = 0.3
    
    var removableNodes:[SKNode] = []
    let mySpacecrafts:[GarageSpacecraft] = [GarageSpacecraft(name: "mercury"), GarageSpacecraft(name: "apollo"), GarageSpacecraft(name: "shuttle"), GarageSpacecraft(name: "dreamchaser")]
    let myTitles:[String] = ["The Atlas", "The Apollo", "The Endeavour", "The Dream Chaser"]
    var current = 0
    
    var timer: Timer!
    var startTime: DispatchTime?
    var elapsedTime: TimeInterval = 0
    var isGamePaused: Bool {
        return startTime == nil
    }
        
    init(levelID: String, spaceship: Spaceship, stars: [Star], in view: UIView) {
        
        self.spaceship = spaceship
        self.stars = stars
        self.initialPosition = spaceship.position
        self.levelID = levelID
        
        let hubble = Hubble(radius: 50,
                            position: CGPoint(x: 270, y: 0),
                            strength: 0.001,
                            angularVelocity: 0)
        
        boundMax = view.bounds.width/2
        
        boostBar = BoostBar(position: CGPoint(x: -131, y: view.bounds.size.height/2 - 59))
        
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
        
        displaySpaceshipChoice()
        addChild(labelNode)
        self.labelNode.preferredMaxLayoutWidth = 250
        self.labelNode.fontSize = 15
        self.labelNode.fontColor = UIColor.white
        self.labelNode.position = CGPoint(x: 250, y: 0)
        self.labelNode.numberOfLines = 0
        self.labelNode.verticalAlignmentMode = .center
        self.labelNode.horizontalAlignmentMode = .right
        self.labelNode.zPosition = 5
        
        addChild(titleNode)
        self.titleNode.preferredMaxLayoutWidth = 200
        self.titleNode.fontSize = 20
        self.titleNode.fontColor = UIColor.white
        self.titleNode.position = CGPoint(x: 30, y: 120)
        self.titleNode.numberOfLines = 0
        self.titleNode.horizontalAlignmentMode = .left
        self.titleNode.zPosition = 5
        
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
            let touchedNode = self.atPoint(location)
            
            if let spacecraft = touchedNode as? GarageSpacecraft {
                hasChosen = true
                displayGame()
            }
            if hasChosen {
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
            
            else {
                
                if location.x > 0 {
                    swipeLeft()
                }
                else {
                    swipeRight()
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if hasChosen {
            if !hasLaunched && playing {
                for touch in touches {
                    let location = touch.location(in: self)
                    self.finalPoint = location
                    pathNode.removeFromParent()
                    drawLine(to: location)
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if hasChosen {
            if !hasLaunched && playing {
                pathNode.removeFromParent()
                let velocity = CGVector.new(pointA: (spaceship?.position)!, pointB: finalPoint!)
                self.spaceship?.physicsBody?.isDynamic = true
                self.spaceship?.physicsBody?.velocity = velocity/5
                hasLaunched = true
            }
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
    
    func startGameTimer() {
        guard isGamePaused else { return }
        
        startTime = DispatchTime.now()
    }
    
    func pauseGameTimer() {
        guard !isGamePaused else { return }
        
        let endTime = DispatchTime.now()
        let elapsedNano: Double = Double(endTime.uptimeNanoseconds - startTime!.uptimeNanoseconds)
        self.elapsedTime += elapsedNano/1_000_000_000
        
        startTime = nil
    }
    
    func pause() -> Bool {
        guard !isGamePaused else { return false }
        
        self.isPaused = true
        pauseGameTimer()
        
        startTime = nil
        
        return true
    }
    
    func play() {
        self.isPaused = false
        startGameTimer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if hasChosen {
            displayGame()
        }
        
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
        let background = SKTexture(imageNamed: self.levelID)
        let backgroundNode = SKSpriteNode(texture: background)
        backgroundNode.zPosition = 4
        let colorSprite = SKSpriteNode(texture: nil, color: .black, size: background.size())
        colorSprite.zPosition = 5
        addChild(colorSprite)
        colorSprite.alpha = 0.5
        addChild(backgroundNode)
        self.removableNodes.append(backgroundNode)
        self.removableNodes.append(colorSprite)
        displaySpacecraft(current: 0)
    }
    
    func displayGame() {
        self.spaceship?.texture = mySpacecrafts[current].texture
        for nodes in removableNodes {
            nodes.removeFromParent()
        }
        self.labelNode.removeFromParent()
        self.titleNode.removeFromParent()
    }
    
    func displaySpacecraft(current: Int) {
        let spacecraft = self.mySpacecrafts[current]
        addChild(spacecraft)
        self.removableNodes.append(spacecraft)
        spacecraft.zPosition = 5
        let text = spacecraft.descriptionText
        self.labelNode.text = text
        self.titleNode.text = myTitles[current]
    }
    
    func swipeLeft() {
     
        if self.current == 3 {
            self.current = 0
        } else {
            self.current += 1
        }
        self.removableNodes[self.removableNodes.count - 1].removeFromParent()
        self.removableNodes.remove(at: self.removableNodes.count - 1)
        displaySpacecraft(current: self.current)
        
    }
    
    func swipeRight() {
        if self.current == 0 {
            self.current = 3
        } else {
            self.current -= 1
        }
        self.removableNodes[self.removableNodes.count - 1].removeFromParent()
        self.removableNodes.remove(at: self.removableNodes.count - 1)
        displaySpacecraft(current: self.current)
    }
}
