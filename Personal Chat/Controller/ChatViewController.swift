//
//  ChatViewController.swift
//  Personal Chat
//
//  Created by shivakumar chirra on 27/05/25.
//

import Foundation
import UIKit

class ChatViewController :UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func senderPressed(_ sender: UIButton) {
    }
}
