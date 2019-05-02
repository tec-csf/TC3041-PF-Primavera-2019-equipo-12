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
    var locationG: String!
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
            .appendingPathComponent("Guardabosques.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, job TEXT, location TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
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
    
    
    func createDB() {
        
        // Only if Firebase register was succesful, then update local SQLite Database
        let name = self.nameTextField.text!//.trimmingCharacters(in: .whitespacesAndNewlines)
        let job = self.jobTextField.text!//.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = self.emailTextfield.text!//.trimmingCharacters(in: .whitespacesAndNewlines)
        let location = self.locationG!
        
        
        print("name:",name)
        print("job:",job)
        print("email:",email)
        print("location:",location)
        
        //.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO Users (name, email, job, location) VALUES (?,?,?,?)"
        
        //preparing the query
        if sqlite3_prepare(self.db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //binding the parameters
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        if sqlite3_bind_text(stmt, 2, email, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        if sqlite3_bind_text(stmt, 3, job, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        if sqlite3_bind_text(stmt, 4, location, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        
        
        //executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(self.db)!)
            print("failure inserting User: \(errmsg)")
            return
        }
        
        
        //displaying a success message
        print("User saved successfully")
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
                
                self.createDB()
                
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToMenu", sender: self)
                
                
                
            }
        }
        
    }
    
    
}

