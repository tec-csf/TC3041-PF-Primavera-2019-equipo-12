//
//  ProfileViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase
import SQLite3

class ProfileViewController: UIViewController {
    
    var db: OpaquePointer?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //the SQLITE database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Guardabosques7.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        getUserData()
        
    }
    
    func getUserData() {
        
        let queryStatementString = "SELECT * FROM User;"
        
        var queryStatement: OpaquePointer? = nil
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // 3
                let id = sqlite3_column_int(queryStatement, 0)
                
                // 4
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let name = String(cString: queryResultCol1!)
                
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let email = String(cString: queryResultCol2!)
                
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                let job = String(cString: queryResultCol3!)
                
                let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
                let location = String(cString: queryResultCol4!)
                
                // 5
                print("Query Result:")
                print("\(id) | \(name) | \(email) | \(job) | \(location)")
                
                nameLabel.text = name
                emailLabel.text = email
                jobLabel.text = job
                locationLabel.text = location
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        // 6
        sqlite3_finalize(queryStatement)
        
    }
    
    func getUserDataViejo() {
        
//        let queryString = "SELECT * FROM Users"
//        //WHERE email = '\(String(describing: Auth.auth().currentUser!.email!))'"
//        //let queryString = "SELECT * FROM Users WHERE email = \(String(describing: Auth.auth().currentUser!.email!))"
//        print(queryString)
//
//        //statement pointer
//        var stmt:OpaquePointer?
//
//        //preparing the query
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errmsg)")
//            return
//        }
//
//        //traversing through all the records
//        while(sqlite3_step(stmt) == SQLITE_ROW){
//            //let id = sqlite3_column_int(stmt, 0)
//            print("hola")
//            let name = String(cString: sqlite3_column_text(stmt, 1))
//            let email = String(cString: sqlite3_column_text(stmt, 2))
//            let job = String(cString: sqlite3_column_text(stmt, 3))
//            let location = String(cString: sqlite3_column_text(stmt, 4))
////
////
//              print("1",String(cString: sqlite3_column_text(stmt, 1)))
//              print("2",String(cString: sqlite3_column_text(stmt, 2)))
//              print("3",String(cString: sqlite3_column_text(stmt, 3)))
//              print("4",String(cString: sqlite3_column_text(stmt, 4)))
////
////
//              nameLabel.text = name
//              emailLabel.text = email
//              locationLabel.text = location
//              jobLabel.text = job
//
//        }
    }

   
    @IBAction func logout(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch {
            print("error: there was a problem logging out")
        }
        
    }
    
    
    

}
