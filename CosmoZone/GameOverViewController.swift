//
//  GameOverViewController.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-04-03.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showGameScene(_ sender: Any) {
        
    }

    func gameOver() {
        let gameOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOver") as! GameOverViewController
        self.present(gameOverVC, animated: true, completion: nil)
    }
}
