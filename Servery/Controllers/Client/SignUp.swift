//
//  signUp.swift
//  Servery
//
//  Created by jason Moses on 2019/09/29.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignUp: UIViewController {

     var ref: DatabaseReference = Database.database().reference()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var lockIcon: UIImageView!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var userIcon: UIImageView!
    override func viewDidLoad() {
        print("In controller")
        self.view.isUserInteractionEnabled = true
        emailTextField.addTarget(self, action: #selector(textFieldBeganForEmail), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFieldBeganForPassword), for: .editingDidBegin)
        phoneTextField.addTarget(self, action: #selector(textFieldBeganForPhone), for: .editingDidBegin)
        usernameTextField.addTarget(self, action: #selector(textFieldBeganForUser), for: .editingDidBegin)
self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldDismiss)))}
    @IBAction func createAccount(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (auth, error) in
            if error != nil {
                self.view.isUserInteractionEnabled = true
                print(error!)
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)}
            else {
                print("saved")
                let Verification = self.storyboard?.instantiateViewController(identifier: "Verification")
                self.present(Verification!, animated: true, completion: nil)}
        }; ref.child("Userinfo").child("Info").setValue(["userName": usernameTextField.text!, "phoneNumber": phoneTextField.text!])
        UserDefaults.standard.set(usernameTextField.text, forKey: "Username");         UserDefaults.standard.set(phoneTextField.text, forKey: "PhoneNumber")}
    @objc func textFieldBeganForEmail() {
        emailIcon.isHidden = true
    }
    @objc func textFieldBeganForPassword() {
        lockIcon.isHidden = true
    }
    @objc func textFieldBeganForPhone() {
        phoneIcon.isHidden = true
    }
    @objc func textFieldBeganForUser() {
        userIcon.isHidden = true
    }
    @objc func textFieldDismiss() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        phoneTextField.endEditing(true)
        usernameTextField.endEditing(true)
    }
    
    
}
