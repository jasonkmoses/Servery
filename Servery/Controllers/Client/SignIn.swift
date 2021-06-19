//
//  SignIn.swift
//  Servery
//
//  Created by jason Moses on 2019/10/01.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
class SignIn: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    override func viewDidLoad() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditing), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditing), for: .editingChanged)
        self.view.isUserInteractionEnabled = true
 self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldDismiss)))}
        @IBAction func logIn(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (auth, e) in
            if e != nil {
                print(e!)
                self.view.isUserInteractionEnabled = true
                let alert = UIAlertController(title: "Error", message: "\(e!.localizedDescription)", preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionSignUp = UIAlertAction(title: "Sign Up", style: .default) { (alert) in
                    let vc = self.storyboard?.instantiateViewController(identifier: "SignUp")
                    self.present(vc!, animated: true, completion: nil)}
                alert.addAction(actionCancel)
                alert.addAction(actionSignUp)
                self.present(alert, animated: true, completion: nil)}
            else {
                print("moving on")
                let mainvc = self.storyboard?.instantiateViewController(identifier: "MainVC")
                self.present(mainvc!, animated: true, completion: nil)
            }
        }
    }
    @objc func emailTextFieldEditing() {
        emailIcon.isHidden = true
    }
    @objc func passwordTextFieldEditing() {
        passwordIcon.isHidden = true
    }
    @objc func textFieldDismiss() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
}
