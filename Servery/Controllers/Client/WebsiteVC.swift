//  WebsiteVC.swift
//  Servery
//  Created by jason Moses on 2019/10/25.
//  Copyright © 2019 jason Moses. All rights reserved.
import Foundation
import UIKit
import SafariServices
class WebsiteVC: UIViewController , SFSafariViewControllerDelegate {
    let urlWebsite = "https://serveryorignal.000webhostapp.com/index.php"
    let urlInstagram = "https://www.instagram.com/serveryoriginal/?hl=en"
    let urlFacebook = "https://www.facebook.com/Serveryoriginal/?modal=admin_todo_tour"
    override func viewDidLoad() {
        print("WebsiteVC")}
    @IBAction func cancel(_ sender: Any) {
        print("dismissed")
        dismiss(animated: true, completion: nil)
    }; @IBAction func websiteBtn(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: urlWebsite)!)
        present(vc, animated: true, completion: nil)
    }; @IBAction func instagramBtn(_ sender: Any) {
         let vc = SFSafariViewController(url: URL(string: urlInstagram)!)
        present(vc, animated: true, completion: nil)
    };@IBAction func FacebookBtn(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: urlFacebook)!)
        present(vc, animated: true, completion: nil)
    }
    
}
