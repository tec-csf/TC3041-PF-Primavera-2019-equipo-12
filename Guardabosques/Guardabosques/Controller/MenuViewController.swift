//
//  MenuViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/23/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var category: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func floraButton(_ sender: Any) {
        category = "flora"
        performSegue(withIdentifier: "goToFeed", sender: self.category)
    }
    
    @IBAction func faunaButton(_ sender: Any) {
        category = "fauna"
        performSegue(withIdentifier: "goToFeed", sender: self.category)
    }
    
    @IBAction func weatherButton(_ sender: Any) {
        category = "weather"
        performSegue(withIdentifier: "goToFeed", sender: self.category)
    }
    
    @IBAction func alertsButton(_ sender: Any) {
        category = "alerts"
        performSegue(withIdentifier: "goToFeed", sender: self.category)
    }
    
    //Prepare for Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToFeed")
        {
            //Creamos una variable que es literal una copia del LowerViewController
            let FeedController = segue.destination as! FeedViewController
            //Podemos acceder a sus variables
            if let stringToSend = sender as? String {
                FeedController.recievedCategory = stringToSend
            }
        }
    }

   

}
