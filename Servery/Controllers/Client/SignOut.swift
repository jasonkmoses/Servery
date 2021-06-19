//
//  SignOut.swift
//  Servery
//
//  Created by jason Moses on 2019/12/19.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class SignOut:UIViewController{
    override func viewDidLoad() {
        print("Entering Sign Out VC")
        overrideUserInterfaceStyle =  .dark
    }
    @IBAction func signOutBtn(_ sender: Any) {
        do {
        try Auth.auth().signOut()
            present((storyboard?.instantiateViewController(identifier: "FirstView"))!, animated: true, completion: nil)
        }
        catch {
            print("Error")
            let alert = UIAlertController(title: "Error", message: "There is an unexpected error that occured we have reported it already", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
