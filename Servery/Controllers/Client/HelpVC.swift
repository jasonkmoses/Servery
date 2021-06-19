//
//  HelpVC.swift
//  Servery
//
//  Created by jason Moses on 2019/10/25.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
class HelpVC: UIViewController , SFSafariViewControllerDelegate{
    let url = "https://serveryorignal.000webhostapp.com/Jobs.php"
    override func viewDidLoad() {
        print("Help vc")
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
    }
    @IBAction func cancel(_ sender: Any) {
        print("dismissed")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func jobsAvalible(_ sender: Any) {
        let sf = SFSafariViewController(url: URL(string:url) ?? URL(string: "#")!)
        present(sf, animated: true, completion: nil)
        
    }
    

    
}

