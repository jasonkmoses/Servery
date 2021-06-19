//
//  DeleteOut.swift
//  Servery
//
//  Created by jason Moses on 2019/12/19.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class DeleteOut:UIViewController{
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var emailText: UITextField!
    var ref:DatabaseReference = Database.database().reference()
    override func viewDidLoad(){
        overrideUserInterfaceStyle = .dark
        print("Delete VC loaded")
    }
    @IBAction func deleteBtn(_ sender: Any) {
        if emailText.text == Auth.auth().currentUser?.email {  Auth.auth().currentUser?.delete(completion: { (e) in
                if e != nil {
                    print(e as Any)
                }
                else{
                    print("successfully deleted")
                    let vc = self.storyboard?.instantiateViewController(identifier: "FirstView")
                    self.present(vc!, animated: true, completion: nil)
                }
            })
            } else {
            if TextView.text == "" || TextView.text == nil {
                TextView.text = "Please fill this field in."
            }
            else {
    ref.child("deletedInfo").setValue(["Email":emailText.text,"Reason":TextView.text])
            }
        }

    }
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
