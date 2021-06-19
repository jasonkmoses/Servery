//
//  SelectJob.swift
//  Servery
//
//  Created by jason Moses on 2019/11/19.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit

class SelectJob: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var imageView: UIImageView!
    var jobs = ["Plumber","Electrician","House Painter","Domestic Worker","Builder","Gardner","Babysitter","Pool Cleaner", "Carpenter", "House Moving Driver","Barber"]
    var data:String = ""
    let picker = UIPickerView()
    @IBOutlet weak var UIpicker: UIPickerView!
    override func viewDidLoad() {
        UIpicker.delegate = self
        UIpicker.dataSource = self
        UIpicker.setValue(UIColor.black, forKey: "textColor")
        imageView.layer.zPosition = -3
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jobs.count
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jobs[row]
    }
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(jobs[row])
        UIpicker.setValue(UIColor.black, forKey: "textColor")
        let vc = storyboard?.instantiateViewController(identifier: "MainVCWorker") as? MainVCWorker
        self.data = jobs[row]
        UserDefaults.standard.set(self.data, forKey: "Job")
    navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
