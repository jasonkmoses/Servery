//
//  MainVCWorker.swift
//  Servery
//
//  Created by jason Moses on 2019/11/11.
//  Copyright © 2019 jason Moses. All rights reserved.
import Foundation
import UIKit
import CoreLocation
import Alamofire
import SQLite
import SQLite3
import MapKit
import SwiftyJSON
import FirebaseAuth
class MainVCWorker: UIViewController , CLLocationManagerDelegate,UINavigationControllerDelegate{
    let slideTrans = SlideInTrans()
    @IBOutlet weak var requestBTN: UIButton!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var mapView: MKMapView!
    var Database: Connection!
    let weatherDataModel = WeatherDataModel()
    var request = "Request Button"
    var data = ""
    let url = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "ae2e13d466c4c44a20f2829b9bc0ee43"
    let parmas = [String:String]()
    let services = ["","Plumber","Electrician","House Painter","Domestic Worker","Builder","Gardner","Babysitter","Pool Cleaner", "Carpenter", "House Moving Driver","Barber"]
    let locationManager = CLLocationManager()
    let tb = Table("info")
    var email = Expression<String>("email")
    var locationLongitude = Expression<Int>("location")
    var locationLatitude = Expression<Int>("location")
    var numberPhone =  Expression<Int>("PhoneNumber")
    var photo = Expression<String>("photo")
    var jobSelector = Expression<String>("jobSelector")
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        print(data)
        requestBTN.setTitle(request, for: .normal)
        sendData(display: self.data)
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
        print("\(String(describing: locationManager.location?.coordinate))")
        print("in view controller now")}
        else {print(Error.self)}
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
            stepper.maximumValue = 9
            stepper.minimumValue = 0.5
              stepper.isContinuous = false
              stepper.autorepeat = false
              stepper.wraps = false
            stepper.addTarget(self, action: #selector(takeToNextController), for: .allTouchEvents)
           currencyLbl.text = Locale.current.currencySymbol
    }
    @IBAction func requestBtnTapped(_ sender: Any) {    postDataToAPI()
        getDataFromAPI() }
    func saveData(data: String) {
        do {
        let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let file = url.appendingPathExtension("info").appendingPathComponent("sqlite3")
            let db = try Connection(file.path)
            self.Database = db} catch {print("error with sql and database")}
       let crTable = tb.create { (table) in
        table.column(email)
        table.column(numberPhone)
        table.column(locationLongitude)
        table.column(locationLatitude)
        table.column(photo)
        table.column(jobSelector)
        }
        do { try Database.run(crTable) }
        catch { print(error) }
        let insertedData = tb.insert(email <- (Auth.auth().currentUser?.email)!, numberPhone <- Int("0998") ?? 000000000, locationLongitude <- Int(CLLocationManager().location?.coordinate.longitude ?? 0) ,locationLatitude <- Int(CLLocationManager().location?.coordinate.latitude
             ?? 0), photo <- "", jobSelector <- self.data)
        do { try Database.run(insertedData)
            print("inserted user")
        }
        catch { print("SQL has faield") }
        do {
            let db = try Database.prepare(self.tb)
            for table in db { print(table) } }
        catch { print(error) }
}
    @objc func takeToNextController() {
           let alert = UIAlertController(title: "Please Select a job first", message: nil, preferredStyle: .alert)
           let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
                           let selectService = self.storyboard?.instantiateViewController(identifier: "navVC")
               self.present(selectService!, animated: true, completion: nil)
           }
           alert.addAction(action)
           present(alert, animated: true,completion:nil )
           }
    @IBAction func weatherIconBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "WeatherVC")
        present(vc!, animated: true, completion: nil)
    }

    @IBAction func navBar(_ sender: Any) {
        self.view.isUserInteractionEnabled = true
        guard let sideMenu = storyboard?.instantiateViewController(identifier: "SideMenuWorker") as? SideMenuWorker else {return}
        sideMenu.modalPresentationStyle = .overCurrentContext
        sideMenu.transitioningDelegate = self
        present(sideMenu, animated: true)
    }
    
    @IBAction func moreBtn(_ sender: Any) {
    }
    func sendData(display: String) {
        print("sending data")
        let alert = UIAlertController(title: "You choose to be a \(display)", message: "You can always change it by pressing the worker icon on the right if you want.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            print("cancel")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }; func getDataFromAPI()  {
        guard let url = URL(string: "https://dry-dawn-26797.herokuapp.com/getting") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, e) in
            if e != nil {
                print(e!)
                let alert = UIAlertController(title: "Error", message: "An error occured error description: \(e ?? e!)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionTry = UIAlertAction(title: "Try Agian", style: .default) { (alert) in }
                alert.addAction(action)
                alert.addAction(actionTry)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                        print(JSON(json))
                    print(data)
                    } catch {
                        print(error)
                    }
                }
            }
        }.resume()
    }
    func postDataToAPI()  {
        let parmas = ["email" : Auth.auth().currentUser?.email ?? "g@g.com", "username": "Jason",  "JobDescription":  UserDefaults.standard.object(forKey: "Job") as! String,
        "Image": "!",
        "PhoneNumber": 0987,
        "locationLatitude": Int(CLLocationManager().location?.coordinate.latitude ?? 0),
        "locationLongitude":Int(CLLocationManager().location?.coordinate.longitude ?? 0),
        "worker": true,
        "active": true] as [String : Any]
        var request = URLRequest(url: URL(string: "https://dry-dawn-26797.herokuapp.com/posting")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        guard let htttpBody = try? JSONSerialization.data(withJSONObject: parmas, options: .fragmentsAllowed) else {return}
        request.httpBody = htttpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, e) in
            if e != nil {
                print(e!)
                let alert = UIAlertController(title: "Error", message: "An error occured error description: \(e ?? e!)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let  actionTry = UIAlertAction(title: "Try Agian", style: .default) { (alert) in }
                alert.addAction(action)
                alert.addAction(actionTry)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do { let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(JSON(json))
                    print(data)
                    }
                catch {
                    print(error)
                }
                }
              }
        }.resume()  }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[locations.count - 1]
        if loc.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(loc.coordinate.longitude), latitude = \(loc.coordinate.latitude)")
            
        }
          func userLocationAnnotationView() {
            let userLocation = CLLocationCoordinate2D(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)
             let userPlaceMark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
             
             let userAnnotation = CustomPointAnnotation()
        
             if let location = userPlaceMark.location {
                 userAnnotation.title = "My Location (You)"
                userAnnotation.subtitle = "You"
                 userAnnotation.coordinate = location.coordinate
             }
            let annotationView = MKAnnotationView(annotation: userAnnotation, reuseIdentifier: "pin")
            userAnnotation.pinCustomImageName = "pin"
            annotationView.image = UIImage(contentsOfFile: userAnnotation.pinCustomImageName)
            self.mapView.showAnnotations([annotationView.annotation!], animated: true)
            
         }
        userLocationAnnotationView()
    };
}


extension MainVCWorker: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideTrans.isPresenting = true
        return slideTrans
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideTrans.isPresenting = false
        return slideTrans
    }
}
