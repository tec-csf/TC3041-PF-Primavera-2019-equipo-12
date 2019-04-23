//
//  WelcomeViewController.swift
//  
//
//  Created by JJ Santos on 4/23/19.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // If there is a logged in user, skip this screen and go straight to MenuViewController
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToMenu", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
