//
//  SelectService.swift
//  Servery
//
//  Created by jason Moses on 2019/10/11.
//  Copyright © 2019 jason Moses. All rights reserved.
//

import Foundation
import UIKit

class SelectService: UITableViewController {
    let services = ["","Plumber","Electrician","House Painter","Domestic Worker","Builder","Gardner","Babysitter","Pool Cleaner", "Carpenter", "House Moving Driver","Barber"]
    var data = ""
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForServices", for: indexPath)
        cell.textLabel?.text = services[indexPath.row]
        cell.textLabel?.textColor = UIColor(named: "")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if services[indexPath.row] == services[0] {
           
       
       }
       else { data = services[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "MainVC") as? MainVC
        vc?.data = data


        navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
    @IBAction func cancelVC(_ sender: Any) {
        navigationController?.topViewController?.dismiss(animated: true, completion: nil)
            print("j g")
    }
}
