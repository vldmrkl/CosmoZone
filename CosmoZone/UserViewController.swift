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
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startGameButton.layer.borderWidth = 1
        startGameButton.layer.cornerRadius = 12
        errorLabel.isHidden = true
        self.userNameInput.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func startGame(_ sender: Any) {
        if userNameInput.text!.isEmpty{
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
            self.present(gameVC, animated: true, completion: nil)
        }
    }
}
