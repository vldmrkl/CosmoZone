//
//  GameScene.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-03-29.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfall: SKEmitterNode!
    var spaceship: SKSpriteNode!
    var score: Int = 0
    var scoreLabel: SKLabelNode!

    var ufoTimer: Timer?
    var rocketTimer: Timer?

    let ufoCategory: UInt32 = 0x1 << 0
    let rocketCategory: UInt32 = 0x1 << 1
    let spaceshipCategory: UInt32 = 0x1 << 2

    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressure))
        self.view!.addGestureRecognizer(longPressRecognizer)

        starfall = SKEmitterNode(fileNamed: "Starfall")
        starfall.position = CGPoint(x: 0, y: 1000)
        starfall.advanceSimulationTime(10)
        starfall.zPosition = -1
        self.addChild(starfall)

        spaceship = SKSpriteNode(imageNamed: "spaceship")
        spaceship.position = CGPoint(x: 0, y: -self.frame.size.height/2 + 200)
        spaceship.zPosition = 1

        spaceship.physicsBody = SKPhysicsBody(rectangleOf: spaceship.size)
        spaceship.physicsBody?.affectedByGravity = false

        spaceship.physicsBody?.categoryBitMask = spaceshipCategory
        spaceship.physicsBody?.contactTestBitMask = ufoCategory
        spaceship.physicsBody?.collisionBitMask = 0

        self.addChild(spaceship)

        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel.text = "Score: \(score)"

        ufoTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.createUFO()
        })

        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shootRocket()
    }

    func createUFO(){
        let ufo = SKSpriteNode(imageNamed: "ufo")
        ufo.size = CGSize(width: 150, height: 75)
        ufo.physicsBody = SKPhysicsBody(rectangleOf: ufo.size)

        ufo.physicsBody?.affectedByGravity = false
        ufo.physicsBody?.isDynamic = true

        ufo.physicsBody?.categoryBitMask = ufoCategory
        ufo.physicsBody?.contactTestBitMask = rocketCategory | spaceshipCategory
        ufo.physicsBody?.collisionBitMask = 0

        self.addChild(ufo)

        let minX = -size.width/2 + ufo.size.width
        let maxX = size.width/2 - ufo.size.width
        let range = maxX - minX
        let randomUfoX = maxX - CGFloat(arc4random_uniform(UInt32(range)))

        ufo.position = CGPoint(x: randomUfoX, y: size.height / 2 + ufo.size.height / 2)

        let flyDown = SKAction.moveBy(x: 0, y: -size.height - ufo.size.height, duration: 4)
        let moveUFO = SKAction.sequence([flyDown, SKAction.removeFromParent()])

        ufo.run(moveUFO)
    }

    func shootRocket() {
        let rocket = SKSpriteNode(imageNamed: "rocket")
        rocket.size = CGSize(width: 15, height: 60)
        rocket.position = spaceship.position
        rocket.zPosition = 0

        rocket.physicsBody = SKPhysicsBody(rectangleOf: rocket.size)
        rocket.physicsBody?.affectedByGravity = false
        rocket.physicsBody?.isDynamic = false

        rocket.physicsBody?.categoryBitMask = rocketCategory
        rocket.physicsBody?.contactTestBitMask = ufoCategory

        self.addChild(rocket)

        let flyUP = SKAction.move(to: CGPoint(x: spaceship.position.x, y: self.frame.size.height+50), duration: 1)
        let moveRocket = SKAction.sequence([flyUP, SKAction.removeFromParent()])

        rocket.run(moveRocket)
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == ufoCategory && contact.bodyB.categoryBitMask == rocketCategory {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            score += 1
            scoreLabel.text = "Score: \(score)"
        } else if contact.bodyA.categoryBitMask == rocketCategory && contact.bodyB.categoryBitMask == ufoCategory {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            score += 1
            scoreLabel.text = "Score: \(score)"
        } else if contact.bodyA.categoryBitMask == ufoCategory && contact.bodyB.categoryBitMask == spaceshipCategory {
            contact.bodyA.node?.removeFromParent()
            score -= 1
            scoreLabel.text = "Score: \(score)"
        } else if contact.bodyA.categoryBitMask == spaceshipCategory && contact.bodyB.categoryBitMask == ufoCategory {
            contact.bodyB.node?.removeFromParent()
            score -= 1
            scoreLabel.text = "Score: \(score)"
        }
    }

    @objc func handleLongPressure(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            rocketTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true, block: { (timer) in
                self.shootRocket()
            })
        } else if (sender.state == UIGestureRecognizer.State.ended){
            rocketTimer?.invalidate()
        }
    }

    override func didSimulatePhysics() {
        spaceship.position.x += xAcceleration * 50

        if spaceship.position.x < -self.frame.size.width/2 - 180 {
            spaceship.position = CGPoint(x: self.frame.size.width/2, y: spaceship.position.y)
        }else if spaceship.position.x > self.frame.size.width/2 + 180 {
            spaceship.position = CGPoint(x: -self.frame.size.width/2, y: spaceship.position.y)
        }

    }
}
