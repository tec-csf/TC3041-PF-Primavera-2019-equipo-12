//
//  FeedViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    var recievedCategory: String!
    var reportArray : [Report] = [Report]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        self.title = recievedCategory.uppercased()
        
        retrieveReports()
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func retrieveReports() {
        
        let reportsDB = Database.database().reference().child(recievedCategory)
        
        reportsDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let title = snapshotValue["Title"]!
            let message = snapshotValue["MessageBody"]!
            let username = snapshotValue["Username"]!
            let location = snapshotValue["Location"]!
            let likes = snapshotValue["Likes"]!
            
            let report = Report()

            report.title = title
            report.message = message
            report.username = username
            report.location = location
            report.likes = likes
            
            
            self.reportArray.append(report)
            
            self.tableview.reloadData()
            
            
        }
        
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
    
        cell.title.text = reportArray[indexPath.row].title
        cell.location.text = reportArray[indexPath.row].location
        cell.message.text = reportArray[indexPath.row].message
        cell.username.text = reportArray[indexPath.row].username
        cell.likes.text = reportArray[indexPath.row].likes
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reportArray[indexPath.row].likes = "1"
        
        
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
