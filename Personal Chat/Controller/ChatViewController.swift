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
    let db = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = Constants.appName
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifyer)
        loadMessages()
        
    }
    func loadMessages(){
       
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error{
                print("issues in retribing datat from foreStore \(e)")
            }else{
                if let  snapshotDocuments =  querySnapshot?.documents {
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            
                            DispatchQueue.main.async{
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section : 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func senderPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data:[Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody,Constants.FStore.dateField: Date().timeIntervalSince1970]){ (error) in
                if let e = error{
                    print("Error adding document: \(e)")
                }else{
                    print("Document added successfully")
                    DispatchQueue.main.async{
                        self.messageTextField.text = ""
                    }
                }
            }
        }
        
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
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifyer, for: indexPath) as! MessageCell
        cell.label.text = message.body

        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.label.textColor =  UIColor(named: Constants.BrandColors.lightPurple)
        }
        
        return cell
    }
}
