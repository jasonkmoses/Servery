//
//  EditVCWorker.swift
//  Servery
//
//  Created by jason Moses on 2019/11/18.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit
import SQLite
import FirebaseAuth

class EditVCWorker:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var BioTXT: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    let imagepicker = UIImagePickerController()
    @IBOutlet weak var emaillbl: UILabel!
    override func viewDidLoad() {
        usernameLbl.text = "Username: \(UserDefaults.standard.object(forKey: "UsernameWorker") as? String ?? "?")"
        print("Edit VC")
        emaillbl.text = "Email: \(Auth.auth().currentUser?.email ?? "?@?.com")"
        phoneNumber.text = "Phone Number: \(UserDefaults.standard.object(forKey: "PhoneNumberWorker") as? String ?? "000")"
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        let filemanger = FileManager.default
        do {
            let url = try filemanger.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            _ = filemanger.createFile(atPath: url.path, contents: nil, attributes: nil)
            if filemanger.fileExists(atPath: url.path) {
                print("true")
            }
            else {
                print("false")
            }
        }catch{
            print("error")
        }
    }
    @IBAction func cancel(_ sender: Any) {
        print("dismissed")
        dismiss(animated: true, completion: nil)
    };  @IBAction func cameraPressed(_ sender: Any) {
        present(imagepicker, animated: true, completion: nil)
    };
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]
        imageView.image = image as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
