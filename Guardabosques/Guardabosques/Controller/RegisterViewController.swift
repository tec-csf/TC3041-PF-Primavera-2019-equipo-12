//
//  RegisterViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/23/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SQLite3

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var db: OpaquePointer?
    var locationG: String! = locations[0]
    @IBOutlet var jobTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        //the SQLITE database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("GBDB.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        
        let createTableString = """
        CREATE TABLE IF NOT EXISTS User(
        Id INT PRIMARY KEY NOT NULL,
        Name CHAR(255),
        Email CHAR(255),
        Job CHAR(255),
        Location CHAR(255));
        """
        
        var createTableStatement: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("User table created.")
            } else {
                print("User table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        // 4
        sqlite3_finalize(createTableStatement)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextfield.text = ""
        passwordTextfield.text = ""
        nameTextField.text = ""
        jobTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label: UILabel
        
        if let view = view {
            label = view as! UILabel
        }
        else {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 400))
        }
        
        let title = locations[row]
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        label.attributedText = NSAttributedString(string: title, attributes: attributes)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationG = locations[row]
    }
    
    
    
    func insertUser() {
        let insertStatementString = "INSERT INTO User (Id, Name, Email, Job, Location) VALUES (?, ?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let id: Int32 = 1
            let name: NSString = nameTextField.text! as NSString
            let email: NSString = emailTextfield.text! as NSString
            let job: NSString = jobTextField.text! as NSString
            let location: NSString = locationG! as NSString
            
            print("Inserting:")
            print("id:",id)
            print("name:",name)
            print("email:",email)
            print("job:",job)
            print("location:",location)
            
            // 2
            sqlite3_bind_int(insertStatement, 1, id)
            // 3
            sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, email.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, job.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, location.utf8String, -1, nil)
            
            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        //Set up a new user on Firebase Real Time Database
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!.localizedDescription)
                let alert = UIAlertController(title: "Registration Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            } else {
                print("Registration Successful!")
                
                //Insert to SQLite3
                self.insertUser()
                
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToMenu", sender: self)
                
                
                
            }
        }
        
    }
    
    
}

