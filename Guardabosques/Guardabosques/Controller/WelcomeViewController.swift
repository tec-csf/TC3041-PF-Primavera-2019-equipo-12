//
//  WelcomeViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/23/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // If there is a logged user, go straight to Menu
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToMenu", sender: self)
        }
    }

}
