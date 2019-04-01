//
//  UserViewController.swift
//  CosmoZone
//
//  Created by Volodymyr Klymenko on 2019-03-31.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var userNameInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        startGameButton.backgroundColor = .clear
        startGameButton.layer.borderColor = UIColor.green.cgColor
        startGameButton.layer.borderWidth = 1
        startGameButton.layer.cornerRadius = 12

        self.userNameInput.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
