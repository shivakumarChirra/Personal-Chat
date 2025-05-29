//
//  ChatViewController.swift
//  Personal Chat
//
//  Created by shivakumar chirra on 27/05/25.
//

import Foundation
import UIKit
import Firebase
class ChatViewController :UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = [Message(sender: "s1@gmail.com", body: "HeyBuddy"),
                               Message(sender: "s2@gmail.com", body: "Hi"),
                               Message(sender: "s1@gmail.com", body: "How are you?"),
                               Message(sender: "s2@gmail.com", body: "I am fine")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        title = Constants.appName
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifyer)
        
    }
    
    @IBAction func senderPressed(_ sender: UIButton) {
        
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
        
    }
}
extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifyer, for: indexPath)
        as! MessageCell
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
}
