//
//  ViewController.swift
//  Personal Chat
//
//  Created by shivakumar chirra on 27/05/25.
//

import UIKit
import Foundation

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        var letterIndex = 0
        let titleText = "😉Personal Chat"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * Double(letterIndex), repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            letterIndex += 1
        }
        // Do any additional setup after loading the view.
    }


}

