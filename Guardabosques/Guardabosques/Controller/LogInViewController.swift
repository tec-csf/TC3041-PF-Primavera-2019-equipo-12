//
//  LogInViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/23/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {
    
   
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextfield.text = ""
        passwordTextfield.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Log in an existing user
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!.localizedDescription)
                let alert = UIAlertController(title: "Log In Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            } else {
                print("Log In Successful!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToMenu", sender: self)
                
            }
            
        }
        
    }
    
    
}
