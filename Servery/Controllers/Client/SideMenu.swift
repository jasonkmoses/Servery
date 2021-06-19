//
//  SideMenu.swift
//  Servery
//
//  Created by jason Moses on 2019/10/13.
//  Copyright © 2019 jason Moses. All rights reserved.
import Foundation
import UIKit
import Firebase
enum MenuType: Int {
    case Settings
    case Website
    case Help
    case Edit
    case SwitchToWorker }
class SideMenu: UITableViewController {
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var didTapMenuType: ((MenuType) -> Void)?
     let slideTranstioning = SlideInTrans()
    override func viewDidLoad() {
        if UserDefaults.standard.object(forKey: "image") != nil {imageView.image = UIImage(data:(UserDefaults.standard.object(
        forKey: "image") as? Data
        )!)}
        tableView.dataSource = self
        tableView.delegate = self
        view.isUserInteractionEnabled = true
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        emailLbl.text = Auth.auth().currentUser?.email
        if let username = UserDefaults.standard.object(forKey: "Username") as? String {
            usernameLbl.text = username
        } else {print("Failed to bring up username: \(Error.Type.self)")}}
    @IBAction func cancelSideMenu(_ sender: Any) {
        slideTranstioning.isPresenting = false
        self.view.isUserInteractionEnabled = true
        dismiss(animated: true, completion: nil) }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hfgfg")
        guard let menutype = MenuType(rawValue: indexPath.row) else {return}
        self.view.isUserInteractionEnabled = true
        slideTranstioning.isPresenting = false
        dismiss(animated: true) {
            print("\(menutype)")}
    }; @IBAction func settingsPressed(_ sender: Any) {
        print("settings")
        let vc = storyboard?.instantiateViewController(identifier: "SettingsVC")
        present(vc!, animated: true, completion: nil)
     }; @IBAction func websitePressed(_ sender: Any) {
         print("website")
        let vc = storyboard?.instantiateViewController(identifier: "WebsiteVC")
            present(vc!, animated: true, completion: nil)
     }; @IBAction func helpPressed(_ sender: Any) {
         print("help")
        let vc = storyboard?.instantiateViewController(identifier: "HelpVC")
            present(vc!, animated: true, completion: nil)
    }; @IBAction func editPressed(_ sender: Any) {
        print("edit")
        let vc = storyboard?.instantiateViewController(identifier: "EditVC")
            present(vc!, animated: true, completion: nil)
    };@IBAction func switchPressed(_ sender: Any) {
        print("switch")
        prepareForSwitch()
        let alert = UIAlertController(title: "Are you sure?", message: "You will switch to the worker section and stop any progress done here?", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionGo = UIAlertAction(title: "Switch to worker", style: .default) { (alert) in
            let vc = self.storyboard?.instantiateViewController(identifier: "FirstViewWorker")
            self.present(vc!, animated: true, completion: nil)}
        alert.addAction(actionGo)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }; @IBAction func editBtn(_ sender: Any) {
        print("edit")
        let vc = storyboard?.instantiateViewController(identifier: "EditVC")
        present(vc!, animated: true, completion: nil)}
    func prepareForSwitch() {
        UserDefaults.standard.setValue(false, forKey: "LogInUserAuto")
    }
}
