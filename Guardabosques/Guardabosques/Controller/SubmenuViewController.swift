//
//  SubmenuViewController.swift
//  Guardabosques
//
//  Created by JJ Santos on 4/26/19.
//  Copyright © 2019 JJ Santos. All rights reserved.
//

import UIKit

class SubmenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recievedCategory: String!
    var genericArray: [String]!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Categoria Submenu: ")
        //print(recievedCategory)

        self.title = recievedCategory.uppercased()
        
        if (recievedCategory=="flora") { genericArray = flora; image.image = UIImage(named: "leaf") }
        if (recievedCategory=="fauna") { genericArray = fauna; image.image = UIImage(named: "tiger") }
        if (recievedCategory=="weather") { genericArray = weather; image.image = UIImage(named: "ecology") }
        if (recievedCategory=="alerts") { genericArray = alerts; image.image = UIImage(named: "warning") }
        
        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genericArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = genericArray[indexPath.row]
        
        return cell
    }

}
