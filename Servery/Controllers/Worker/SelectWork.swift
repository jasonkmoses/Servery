//
//  selectWork.swift
//  Servery
//
//  Created by jason Moses on 2019/10/04.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit


class selectWork: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var jobs = ["Plumber","Electrician","House Painter","Domestic Worker","Builder","Gardner","Babysitter","Pool Cleaner", "Carpenter", "House Moving Driver","Barber"]
    var data:String = ""
    let picker = UIPickerView()
    @IBOutlet weak var UIpicker: UIPickerView!
    override func viewDidLoad() {
        UIpicker.delegate = self
        UIpicker.dataSource = self
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
        let vc = storyboard?.instantiateViewController(identifier: "MainVCWorker") as? MainVCWorker
         UserDefaults.standard.set(jobs[row], forKey: "Job")
         present(vc!, animated: true, completion: nil) 
    }
    
     
}
