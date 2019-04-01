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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
    }

    func setUpButtons() {
        newGameButton.backgroundColor = .clear
        newGameButton.layer.borderColor = UIColor.green.cgColor
        newGameButton.layer.borderWidth = 1
        newGameButton.layer.cornerRadius = 12

        top10Button.backgroundColor = .clear
        top10Button.layer.borderColor = UIColor.green.cgColor
        top10Button.layer.borderWidth = 1
        top10Button.layer.cornerRadius = 12
    }

}
