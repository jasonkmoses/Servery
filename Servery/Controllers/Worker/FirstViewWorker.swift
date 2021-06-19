//
//  FirstViewWorker.swift
//  Servery
//
//  Created by jason Moses on 2019/09/27.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit

class FirstViewWorker: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        print("Loading FirstViewWorker")
      let date = Date()
        let calander = Locale.current.calendar
        let h = calander.component(.hour, from: date)
        if h >= 0 && h < 12 {
            print("good morining")
            imageView.image = UIImage(named: "GOOD Morning Servery Work")
        }
        else if h >= 12 && h < 18 {
            print("good afternoon")
            imageView.image = UIImage(named: "GOOD Afternoon Servery Work")
        }
        else if h>=18 && h <= 24 {
            print("good evening")
            imageView.image = UIImage(named: "GOOD Evening Servery Work")
        }
        else {
            print(" ")
        }
    }
    @IBAction func switchToClient(_ sender: Any) {
        let firstView = storyboard?.instantiateViewController(identifier: "FirstView")
        present(firstView!, animated: true, completion: nil)
    }
    
}
