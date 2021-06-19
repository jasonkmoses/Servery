//
//  OtherOptions.swift
//  Servery
//
//  Created by jason Moses on 2019/10/01.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class OtherOptions: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
           GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
}
