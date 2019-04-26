//
//  ReportViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ReportViewController: UIViewController {
    
    var recievedArray: [String]!
    
    let report = Report()
    
    
    let name = Auth.auth().currentUser?.email
    var messageBody = ""
    var location = "El Triunfo"
    var category = ""
    var subcategory = ""
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postButton.isEnabled = true

        category = recievedArray[0]
        subcategory = recievedArray[1]
        
    }
    

    @IBAction func post(_ sender: Any) {
        
        SVProgressHUD.show()
        
        messageBody = textView.text!
        textView.endEditing(true)
        //textView.isEnabled = false
        postButton.isEnabled = false
        
        let reportDB = Database.database().reference().child(category)
        
        let reportDictionary = ["Sender": name,
                                "Location": location,
                                "Subject": subcategory,
                                 "MessageBody": messageBody,
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
            }
            
            
            self.postButton.isEnabled = true
            self.textView.text = "Reporte..."
            
            
        }
        
        
        
    }
    

}
