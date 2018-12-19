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
    weak var conversation: Conversation!

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
        navigationItem.title = conversation.description
        configureView()
        DispatchQueue.main.async {
            loadMessages(conv: self.conversation)
            self.tableView.reloadData()
            let indexPath = IndexPath(row: (self.conversation.messages?.count)! - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    var detailItem: Conversation? {
        didSet {
            // Update the view.
            configureView()
            
        }
    }

    @IBOutlet weak var messageTextField: UITextField!
    @IBAction func sendTapped() {
        let message = messageTextField.text
        if (!(message?.isEmpty)!){
            messageTextField.text = ""
            let users = conversation?.users?.allObjects.map { ($0 as? User)?.username }
            let SITE_URL = "https://babelon.herokuapp.com"
            let url = URL(string: "\(SITE_URL)/send_msg")!
            let semaphore = DispatchSemaphore(value: 0)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let params: [String: Any] = [
                "content": message!,
                "usernames": users as! [String],
                ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Print the result
                print(response as Any)
                semaphore.signal()
                }.resume()
            semaphore.wait()
            
            DispatchQueue.main.async {
                loadMessages(conv: self.conversation)
                self.tableView.reloadData()
                let indexPath = IndexPath(row: (self.conversation.messages?.count)! - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return conversation.messages?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "away", for: indexPath)
        
        let mess = (conversation.messages?.allObjects[indexPath.row] as? Message)
        let user = UserDefaults.standard.string(forKey: "username")
        let cell = tableView.dequeueReusableCell(withIdentifier: mess?.sentUser?.username == user ? "away" : "home", for: indexPath)

        cell.textLabel?.text = mess?.content
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


