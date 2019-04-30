//
//  HomeViewController.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-03-31.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var top10Button: UIButton!
    @IBOutlet weak var coinsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        let coins = UserDefaults.standard.integer(forKey: "coins") 
        coinsLabel.text = "\(coins)"
    }

    func setUpButtons() {
        newGameButton.layer.borderWidth = 1
        newGameButton.layer.cornerRadius = 12

        top10Button.layer.borderWidth = 1
        top10Button.layer.cornerRadius = 12
    }

    @IBAction func startGame(_ sender: Any) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        self.present(gameVC, animated: true, completion: nil)
    }
}
