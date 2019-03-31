//
//  GameScene.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-03-29.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var starfall: SKEmitterNode!

    override func didMove(to view: SKView) {
        starfall = SKEmitterNode(fileNamed: "Starfall")
        starfall.position = CGPoint(x: 0, y: 1000)
        starfall.advanceSimulationTime(10)
        starfall.zPosition = -1
        self.addChild(starfall)
    }

    override func update(_ currentTime: TimeInterval) {

    }
}
