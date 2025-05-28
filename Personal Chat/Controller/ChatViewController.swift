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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

