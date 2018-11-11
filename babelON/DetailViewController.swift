//
//  DetailViewController.swift
//  babelON
//
//  Created by Potato on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class DetailViewController: UITableViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    weak var conversation:Conversation?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = conversation?.description
        configureView()
    }

    var detailItem: Conversation? {
        didSet {
            // Update the view.
            configureView()
            
        }
    }

    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func sendTapped(){
        var message = messageTextField.text
        
        //api call to send a message
        //reload table view
        
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return conversation?.messages?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "home", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "away", for: indexPath)

        // Configure the cell...
        
        return cell
    }
    

 
   
 
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


