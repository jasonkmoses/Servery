//
//  Verification.swift
//  Servery
//
//  Created by jason Moses on 2019/10/02.
//  Copyright © 2019 jason Moses. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import CoreML
import Vision
class VerificationWorker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker  = UIImagePickerController()
    override func viewDidLoad() {
        self.view.isUserInteractionEnabled = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true }
    @IBAction func cameraPressed(_ sender: Any) {
      present(imagePicker, animated: true, completion: nil)
    }; func detect(image: CIImage)  {
        do {
            guard let mod = try? VNCoreMLModel(for: ID_CHECKER().model) else { return }
            let request = VNCoreMLRequest(model:mod) { (request, e) in
                 if e != nil {
                     print(e!)
                 }
                 else {
                     let results = request.results as! [VNClassificationObservation]
                     print(results)
                    if results.first?.identifier == "ID" { print("ID");  let selectWork = self.storyboard?.instantiateViewController(identifier: "selectWork")
                     self.present(selectWork!, animated: true, completion: nil)  }
                     else {print("Not ID")
                    } } }
             let handler = VNImageRequestHandler(ciImage: image)
             do {
                 try handler.perform([request])
             } catch {
                 print(error)
             }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage]
        imageView.image = image as? UIImage
        dismiss(animated: true, completion: nil)
        let ciimage = CIImage(image: image as! UIImage)
        detect(image: ciimage!)
    }
       @IBAction func CancelButton(_ sender: Any) {
                self.view.isUserInteractionEnabled = false
                Auth.auth().currentUser?.delete(completion: { (e) in
                    if e != nil { Auth.auth().currentUser?.delete(completion: { (e) in
        if e != nil {
        Auth.auth().currentUser?.delete(completion: { (e) in });fatalError() }
          else {
          let firstVC = self.storyboard?.instantiateViewController(identifier: "FirstView")
           self.present(firstVC!, animated: true, completion: nil) }})
                        let firstVC = self.storyboard?.instantiateViewController(identifier: "FirstView")
                        firstVC?.isModalInPresentation = false
                              self.present(firstVC!, animated: true, completion: nil)
                        print(e!)
                    }
                    else {
                        let firstVC = self.storyboard?.instantiateViewController(identifier: "FirstView")
                              self.present(firstVC!, animated: true, completion: nil)}
                });      self.isModalInPresentation = false }
}
