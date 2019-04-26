//
//  FeedViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var recievedCategory: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(recievedCategory)

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = recievedCategory
        
        return cell
    }
    
    
    @IBAction func new(_ sender: Any) {
        performSegue(withIdentifier: "goToSubmenu", sender: self.recievedCategory)
    }
    
    //Prepare for Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToSubmenu")
        {
            //Creamos una variable que es literal una copia del LowerViewController
            let SubmenuController = segue.destination as! SubmenuViewController
            //Podemos acceder a sus variables
            if let stringToSend = sender as? String {
                SubmenuController.recievedCategory = stringToSend
            }
        }
    }

}
