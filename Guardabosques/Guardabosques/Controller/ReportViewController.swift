//
//  ReportViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit
import Firebase

class ReportViewController: UIViewController {
    
    
    
    let report = Report()
    let name = Auth.auth().currentUser?.email
    let location = "El Triunfo"
    let category = "Ocelote"
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postButton.isEnabled = true

        report.category = category
        
        report.sender = name!
        report.senderLocation = location
    }
    

    @IBAction func post(_ sender: Any) {
        
        report.messageBody = textView.text!
        textView.endEditing(true)
        //textView.isEnabled = false
        postButton.isEnabled = false
        
        let reportDB = Database.database().reference().child(report.category)
        
        let reportDictionary = ["Sender": report.sender,
                                "Location": report.senderLocation,
                                 "MessageBody": report.messageBody,
                                 "Date": Date().debugDescription]
        
        reportDB.childByAutoId().setValue(reportDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Report saved successfully!")
            }
            
            
            self.postButton.isEnabled = true
            self.textView.text = "Report..."
            
            
        }
        
        
        
    }
    

}
