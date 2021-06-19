//
//  FirstView.swift
//  Servery
//
//  Created by jason Moses on 2019/09/25.
//  Copyright © 2019 jason Moses. All rights reserved.
import Foundation
import UIKit
class FirstView: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        let date = Date()
        let calander = Locale.current.calendar
        let h = calander.component(.hour, from: date)
        if h >= 0 && h < 12 {
            print("good morning")
            imageView.image = UIImage(named: "GOOD Morning Servery")
        }
        else if h >= 12 && h < 18 {
            imageView.image = UIImage(named: "GOOD Afternoon Servery")
            print("good afternoon")
            
        }
        else if h >= 18 && h <= 24  {
            print("good evening")
            imageView.image = UIImage(named: "GOOD Evening Servery")
        }
        else {
    print("😦")}
    }
    func autoLogIn() {
        if let stateOfAuth = UserDefaults.standard.object(forKey: "LogInUserAuto") {
            print("State change: \(stateOfAuth)")
            if (stateOfAuth as? Bool)!
            {
            print("trueeeee")
                let vc = storyboard?.instantiateViewController(identifier: "MainVC")
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        autoLogIn()
    }
    @IBAction func signUpBtn(_ sender: Any) {
        print("sign up")
    }
    @IBAction func signInBtn(_ sender: Any) {
        print("sign in")
    }
    @IBAction func switchToWorker(_ sender: Any) {
        print("switch")
        let FirstViewWorker = storyboard?.instantiateViewController(identifier: "FirstViewWorker")
        present(FirstViewWorker!, animated: true, completion: nil)
    }
}
