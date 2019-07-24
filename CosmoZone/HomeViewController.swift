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
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var coinsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()

        let color1 = UIColor(red: 124.0/255.0, green:77.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 63.0/255.0, green: 29.0/255.0, blue: 203.0/255.0, alpha: 1.0)


        view.setGradientBackground(colorOne: color1, colorTwo: color2)

        let coins = UserDefaults.standard.integer(forKey: "coins") 
        coinsLabel.text = "\(coins)"


    }

    func setUpButtons() {
        let brightOrange = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let orange = UIColor(red: 255.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 1.0)

        newGameButton.layer.cornerRadius = newGameButton.frame.size.height / 2
        newGameButton.layer.masksToBounds = true
        newGameButton.setGradientBackground(colorOne: orange, colorTwo: brightOrange)

        storeButton.layer.cornerRadius = storeButton.frame.size.height / 2
        storeButton.layer.masksToBounds = true
        storeButton.setGradientBackground(colorOne: orange, colorTwo: brightOrange)
    }

    @IBAction func startGame(_ sender: Any) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        self.present(gameVC, animated: true, completion: nil)
    }
}

extension UIView {

    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
