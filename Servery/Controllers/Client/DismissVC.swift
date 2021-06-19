//
//  DismissVC.swift
//  Servery
//
//  Created by jason Moses on 2019/12/19.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import MessageUI
class DismissVC: UIViewController,SFSafariViewControllerDelegate,MFMailComposeViewControllerDelegate{
    @IBOutlet weak var usernameTXT: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var descriptionTXT: UITextView!
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappingDismissKeyboard))
        self.view.addGestureRecognizer(tap) }
    func sendMail() -> MFMailComposeViewController {
            let mailVC = MFMailComposeViewController()
                if MFMailComposeViewController.canSendMail() == true {
            mailVC.delegate = self as? UINavigationControllerDelegate
            mailVC.mailComposeDelegate = self
            mailVC.setMessageBody("How can we help you? ", isHTML: false)
            mailVC.setToRecipients(["serveryorgin@gmail.com"])
        }
            else {
                print("the controller cannot send")
                let ALERT = UIAlertController(title: "The Mail page cannot be displayed", message: "An unexpected error has occured we can not identify", preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in }
                ALERT.addAction(action)
                present(ALERT, animated: true, completion: nil) }
            return mailVC
    };
    @IBAction func paymentCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func hoursWorkedCancelled(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func OrderingCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Otherbtn(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    @IBAction func youtubeBtnOfOtherOptions(_ sender: Any) {
        let url = "https://www.youtube.com/channel/UC-sTrTAfmx3e1NmMaFrzFGA"
        let sf = SFSafariViewController(url: URL(string: url)!)
        present(sf, animated: true, completion: nil)
    }
    @IBAction func visitWebsiteFromOtherOptions(_ sender: Any) {
        let url = "https://serveryorignal.000webhostapp.com/index.php"
        let sf = SFSafariViewController(url: URL(string: url) ?? URL(string: "#")!)
        present(sf, animated: true, completion: nil)}
    @IBAction func messageServeryFromOtherOptions(_ sender: Any) {
        present(sendMail(), animated: true, completion: nil)
     }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)}
    @IBAction func dismissFromSettingsVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)}
    @IBAction func AboutBtn(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://serveryorignal.000webhostapp.com/about.php") ?? URL(string:"#")!)
        present(vc, animated: true, completion: nil)}
    @IBAction func cancelSettingsVCWorkers(_ sender: Any) {
        dismiss(animated: true, completion: nil) }
    @IBAction func settingsAboutWorker(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://serveryorignal.000webhostapp.com/about.php") ?? URL(string:"#")!)
        present(vc, animated: true, completion: nil) } //Code for editingVC down =>
    @IBAction func submitUsernameChanges(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "Username")
        UserDefaults.standard.set(usernameTXT.text, forKey: "Username")
    }; @IBAction func submitPhoneChanges(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "PhoneNumber")
        UserDefaults.standard.set(phoneNumber.text, forKey: "PhoneNumber")
    }; @IBAction func submitDescriptionChanges(_ sender: Any) {
        if UserDefaults.standard.object(forKey: "Bio") == nil || UserDefaults.standard.object(forKey: "Bio") as? String == "" {
            descriptionTXT.text = "" } else if descriptionTXT.text!.count<10{
            descriptionTXT.text = "Error Please Type more then 10 characters" } else {UserDefaults.standard.removeObject(forKey: "Bio");UserDefaults.standard.set(descriptionTXT.text, forKey: "Bio")}}
    @IBAction func cancelDescript(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "Canceled?")
        dismiss(animated: true, completion: nil)}
    @IBAction func usernameCancel(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBAction func cancelPhoneNumber(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBAction func cancelPhoneNumberWorker(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBAction func cancelUsernameWOrker(_ sender: Any) {dismiss(animated: true, completion: nil)}
    @IBAction func cancelDescriptionWorker(_ sender: Any)
        {dismiss(animated: true, completion: nil)}
    @objc func tappingDismissKeyboard(){
        if usernameTXT != nil {
            usernameTXT.endEditing(true)}
        if phoneNumber != nil {
            phoneNumber.endEditing(true)}
        if descriptionTXT != nil {
            descriptionTXT.endEditing(true)}}}
