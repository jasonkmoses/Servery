//
//  EditVC.swift
//  Servery
//
//  Created by jason Moses on 2019/10/25.
//  Copyright © 2019 jason Moses. All rights reserved.
//
//  CODE TO USE LATER:
//        imageView.layer.cornerRadius = 170
//        imageView.layer.bounds.size.height = 200
//        imageView.clipsToBounds = true
//

import Foundation
import UIKit
import FirebaseAuth
import SQLite
class EditVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    let imagepicker = UIImagePickerController()
     var database: Connection!
    let userInfo = Table("info")
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var phoneTXT: UILabel!
    @IBOutlet weak var Description: UILabel!
    override func viewDidLoad() {
        if UserDefaults.standard.object(forKey: "image") != nil {
            imageView.image = UIImage(data: UserDefaults.standard.object(forKey: "image") as! Data)
        } else {}
        if UserDefaults.standard.object(forKey: "imageData") != nil {
            UserDefaults.standard.setValue(String(data: UserDefaults.standard.object(forKey: "image") as! Data, encoding: String.Encoding.utf8), forKey: "imageData")
        } else {}
        let savedName = UserDefaults.standard.object(forKey: "Username")
        if let userName = savedName {
            username.text = "Username: \(userName as! String)"
        } else { print("could not open username") }
        if let Number = UserDefaults.standard.object(forKey: "PhoneNumber") {
            phoneTXT.text = "Phone Number: \(Number as! String)"
        } else { print("--could not open phone number")}
        if let BIO = UserDefaults.standard.object(forKey: "Bio") {
            Description.text="Description: \((BIO as! String)[..<(BIO as! String).index((BIO as! String).startIndex,offsetBy:10)])...."
        } else { print("could not open bio")}
        print(userInfo.select(distinct: "email"))
        print("Edit VC")
        emaillbl.text = "Email: \( Auth.auth().currentUser?.email ?? "Email")"
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        print(userInfo)
        let filemanger = FileManager.default
        do {
            let url = try filemanger.url(for: .picturesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            print("Is there a directory part for the file? : \(url.hasDirectoryPath)")
            _ = filemanger.createFile(atPath: url.path, contents: nil, attributes: nil)
            if filemanger.fileExists(atPath: url.path)  {
                print (
                    "true"
                )
                let image =  imageView.image?.pngData()
                do {
                    try image?.write(to:  filemanger.urls(for: .picturesDirectory, in: .userDomainMask)[0].appendingPathComponent(
                        "userImage"
                        )
                    )
                    print (
                        "saved image"
                    )
                    imageView.image = UIImage(contentsOfFile: try String(contentsOf: filemanger.urls(for: .picturesDirectory, in: .userDomainMask)[0]))
                    print("Does the file exist with its path? : \(filemanger.urls(for: .picturesDirectory, in: .userDomainMask)[0])")
                }
                catch {
                    print("error")
                    print(error)
                }
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
        let img = UIImage.pngData((image as? UIImage)!)()
        print(img ?? "j")
        UserDefaults.standard.set(img, forKey: "image")
        dismiss(animated: true, completion: nil)
    }
}
