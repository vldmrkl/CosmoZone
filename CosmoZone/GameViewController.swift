//
//  GameViewController.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-03-29.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                if let gameScene = scene as? GameScene {
                    gameScene.viewController = self
                }
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    func gameOver() {
        let gameOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
        self.present(gameOverVC, animated: true, completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
