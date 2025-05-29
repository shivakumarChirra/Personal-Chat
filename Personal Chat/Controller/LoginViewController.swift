//
//  LoginViewController.swift
//  Personal Chat
//
//  Created by shivakumar chirra on 27/05/25.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    }else {
                        self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
    }
}

