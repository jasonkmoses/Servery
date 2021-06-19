//
//  ReportIssue.swift
//  Servery
//
//  Created by jason Moses on 2019/12/20.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class ReportIssue:UIViewController{
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var phoneNumberText: UITextField!
    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        print("Loaded VC")
    }
    @IBAction func reportBtn(_ sender: Any) {
        let ref:DatabaseReference = Database.database().reference()
        ref.child("Report Issue").child("Report").setValue(["Email": Auth.auth().currentUser!, "Username": usernameText.text!, "Phone Number": phoneNumberText.text!, "Issue":textArea.text ?? "?"])
    }
}
