//
//  ReportViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase
import SQLite3
import SVProgressHUD

class ReportViewController: UIViewController {
    
    var recievedArray: [String]!
    
    let report = Report()
    
    var db: OpaquePointer?
    
    let username = Auth.auth().currentUser?.email
    var messageBody = ""
    var location = ""
    var category = ""
    var subcategory = ""
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        self.postButton.isEnabled = true

        category = recievedArray[0]
        subcategory = recievedArray[1]
        
        //the SQLITE database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Guardabosques7.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        
        getLocation()
    }
    
    
  
    
    
    func getLocation() {
        let queryStatementString = "SELECT Id,Location FROM User;"
        
        var queryStatement: OpaquePointer? = nil
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // 3
                let id = sqlite3_column_int(queryStatement, 0)
                
                // 4
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let locationObtained = String(cString: queryResultCol1!)
                
                
                // 5
                print("Query Result:")
                print("\(id) | \(locationObtained)")
                
                location = locationObtained
                
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        // 6
        sqlite3_finalize(queryStatement)
    }
    

    @IBAction func post(_ sender: Any) {
        
        SVProgressHUD.show()
        
        messageBody = textView.text!
        textView.endEditing(true)
        //textView.isEnabled = false
        postButton.isEnabled = false
        
        let reportDB = Database.database().reference().child(category)
        
        let reportDictionary = ["Username": username,
                                "Location": location,
                                "Title": subcategory,
                                 "MessageBody": messageBody,
                                 "Likes": "0",
                                 "Date": Date().debugDescription]
        
        reportDB.childByAutoId().setValue(reportDictionary) {
            (error, reference) in
            
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
            }
            else {
                SVProgressHUD.dismiss()
                print("Report saved successfully!")
                
                //Pop Back to Menu View Controller
             
                let controllers = self.navigationController?.viewControllers
                for vc in controllers! {
                    if vc is MenuViewController {
                        _ = self.navigationController?.popToViewController(vc as! MenuViewController, animated: true)
                    }
                }
            }
            
            
            self.postButton.isEnabled = true
            self.textView.text = "Reporte..."
            
            
        }
        
        
        
    }
    

}
