//
//  MainVC.swift
//  Servery
//
//  Created by jason Moses on 2019/10/06.
//  Copyright © 2019 jason Moses. All rights reserved.
import Foundation
import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import Alamofire
import SQLite
import FirebaseAuth
import SystemConfiguration
class MainVC: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate
{   var database: Connection!
    let transition = SlideInTrans()
    var topView: UIView?
    @IBOutlet weak var moneyPayment: UILabel!
    @IBOutlet weak var feeLbl: UILabel!
    @IBOutlet weak var hrsLbl: UILabel!
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var requestBTN: UIButton!
//    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var WeatherIcon: UIButton!
    let weatherDataModel = WeatherDataModel()
    var data = "Request Button"
    let parmas = [String:String]()
    let services = ["","Plumber","Electrician","House Painter","Domestic Worker","Builder","Gardner","Babysitter","Pool Cleaner", "Carpenter", "House Moving Driver","Barber"]
    let locationManger = CLLocationManager()
    let tb = Table("info")
    var email = Expression<String>("email")
    var location = Expression<String>("location")
    var numberPhone =  Expression<Int>("PhoneNumber") 
    var photo = Expression<String>("photo")
    var jobSelector = Expression<String>("jobSelector")
    override func viewDidLoad() {
        if Auth.auth().currentUser?.email != nil {
            UserDefaults.standard.setValue(true, forKey: "LogInUserAuto")
        }
//        print(isConnectedToNetwork())
        print(data)
        requestBTN.setTitle(data, for: .normal)
//        sendData(display: self.data)
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger.startUpdatingLocation()
            locationManger.requestWhenInUseAuthorization()
            locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManger.delegate = self
            locationManger.requestAlwaysAuthorization()
        print("\(String(describing: locationManger.location?.coordinate))")
        print("in view controller now")}
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        if requestBTN.currentTitle != "Request Button" {
        requestBTN.layer.cornerRadius = requestBTN.frame.width/2
//        stepper.maximumValue = 9 * 60
//        stepper.minimumValue = 30
//        stepper.isContinuous = false
//        stepper.autorepeat = false
//        stepper.wraps = false
//            stepper.stepValue = 30
//            stepper.value = 0.5
//            stepper.addTarget(self, action: #selector(MainVC.stepperIsChanging(_:)), for: .valueChanged)} else {
//            stepper.maximumValue = 9 * 60
//            stepper.minimumValue = 30
//              stepper.isContinuous = false
//              stepper.autorepeat = false
//              stepper.wraps = false
//            stepper.addTarget(self, action: #selector(takeToNextController), for: .allTouchEvents)
        }
           feeLbl.text = Locale.current.currencySymbol
            do {
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let file = url.appendingPathExtension("sqlite3").appendingPathComponent("info")
                let db = try Connection(file.path)
                self.database = db} catch {print("error with sql")}
    }; @objc func takeToNextController() {
        let alert = UIAlertController(title: "Please Select a job first", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
                        let selectService = self.storyboard?.instantiateViewController(identifier: "navVC")
            self.present(selectService!, animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true,completion:nil )
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if requestBTN.currentTitle != "Request Button"  {
        if segue.identifier == "toSelectService" {
                    let alert = UIAlertController(title: "Are you sure? you want to select another service", message: "You will stop the other service you are trying to order (\( self.requestBTN.currentTitle ?? "?"))", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in}
                    let action2 = UIAlertAction(title: "Ok", style: .default) { (alert) in
                        let vc = self.storyboard?.instantiateViewController(identifier: "SelectService")
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                    alert.addAction(action)
                    alert.addAction(action2)
                    present(alert, animated: true, completion: nil)
            }
        }
        else { return }
    }; @IBAction func searchBar(_ sender: Any) {
       print("searchBtn pressed")
    }
    @IBAction func requestBTNTapped(_ sender: Any) {
        if requestBTN.titleLabel?.text == "Request Button" {
        let alert = UIAlertController(title: "Please Select a job first", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            let selectService = self.storyboard?.instantiateViewController(identifier: "navVC")
                self.present(selectService!, animated: true, completion: nil)
            }
            alert.addAction(action)
            present(alert, animated: true,completion:nil ) }
        else {
                postDataToAPI()
                getDataFromAPI()
                let vc = storyboard?.instantiateViewController(identifier: "MoreVC")
                present(vc!, animated: true, completion: nil)
             }
    }
    @IBAction func moreBTN(_ sender: Any) {
        if requestBTN.titleLabel?.text == "Request Button" {
             let alert = UIAlertController(title: "Please Select a job first", message: nil, preferredStyle: .alert)
                 let action = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
                                 let selectService = self.storyboard?.instantiateViewController(identifier: "navVC")
                     self.present(selectService!, animated: true, completion: nil)
                 }
                 alert.addAction(action)
                 present(alert, animated: true,completion:nil )} else
                { let vc = storyboard?.instantiateViewController(identifier: "MoreVC")
                present(vc!,animated: true,completion: nil)}}
    @objc func stepperIsChanging(_ sender: UIStepper!) {
        hrsLbl.text = "\(Int(sender.value))" }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[locations.count - 1]
        if loc.horizontalAccuracy > 0 {

            locationManger.stopUpdatingLocation()
            
            print("longitude = \(loc.coordinate.longitude), latitude = \(loc.coordinate.latitude)")
        }
          func userLocationAnnotationView() {
            let userLocation = CLLocationCoordinate2D(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)
             let userPlaceMark = MKPlacemark(coordinate: userLocation, addressDictionary: nil)
             
             let userAnnotation = CustomPointAnnotation()
        
             if let location = userPlaceMark.location {
                 userAnnotation.title = "My Location"
                userAnnotation.subtitle = "Me"
                 userAnnotation.coordinate = location.coordinate
             }
            let annotationView = MKAnnotationView(annotation: userAnnotation, reuseIdentifier: "pin")
            userAnnotation.pinCustomImageName = "pin"
            annotationView.image = UIImage(contentsOfFile: userAnnotation.pinCustomImageName)
            mapKitView.showAnnotations([annotationView.annotation!], animated: true)
         }
        userLocationAnnotationView()
    };
 func sendData(display: String) {
        requestBTN.titleLabel?.text = display}
    func retriveData(jobDescription: String) {
        let request = "Request "
        switch requestBTN.titleLabel?.text! {
        case request + services[0] :
            
        break
        
        case request + services[1]:
        
        break
        
        case request + services[2]: break
        
        case request + services[3]: break
    
        case request + services[4]: break
        
        case request + services[5]: break
        
        case request + services[6]: break
        
        case request + services[7]: break
        
        case request + services[8]: break
        
        case request + services[9]: break
        
        case request + services[10]: break
        
        case request + services[11]: break
        
        case request + services[12]: break
        case .none:
            ""
        case .some(_):
            ""
        }
    }
    func saveData(condition: String) {
        if requestBTN.titleLabel?.text == "Requset Button" {return}
        else { let createTable = tb.create { (table) in
               table.column(self.email)
               table.column(self.location)
               table.column(self.numberPhone)
               table.column(self.photo)
               table.column(self.jobSelector)  }
        do {
            try database.run(createTable)
        }catch {
            print(error)
        }
        
        }}
   func isConnectedToNetwork() -> String {
         var zeroAddress = sockaddr_in()
         zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
         zeroAddress.sin_family = sa_family_t(AF_INET)

         guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
             $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                 SCNetworkReachabilityCreateWithAddress(nil, $0)
             }
         }) else {
             return "Connection: \(false)"
         }

         var flags: SCNetworkReachabilityFlags = []
         if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
             return "Connection: \(false)"
         }
         if flags.isEmpty {
             return"Connection: \(false)"
         }

         let isReachable = flags.contains(.reachable)
         let needsConnection = flags.contains(.connectionRequired)

         return ("Final Connection: \(isReachable && !needsConnection)")
     }
    func getDataFromAPI() {
        //This function is getting data from the API
        guard let url = URL(string: "https://dry-dawn-26797.herokuapp.com/getting") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, e) in
            if e != nil {
                print(e!)
                let alert = UIAlertController(title: "Error", message: "Could not connect to serverys server faluire due to \(e?.localizedDescription ?? "\(e!)")", preferredStyle: .alert)
                let tryAgianAction = UIAlertAction(title: "Try Agian", style: .cancel) { (alert) in
                    
                }
                alert.addAction(tryAgianAction)
                self.present(alert, animated: true, completion: nil)
            }
             else {
            if let response = response  {
                print(response) }
                if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(JSON(json))
                    } catch {
                    print(error) }
                }
            }
        }.resume()
    }
    func postDataToAPI() {
        guard let data = UserDefaults.standard.object(forKey: "imageData") else {return}
        let parmas = ["email" : Auth.auth().currentUser?.email ?? "?@?",
        "username": "Jason",
        "JobDescription": requestBTN.titleLabel?.text! as Any,
        "Image": data,
        "PhoneNumber": UserDefaults.standard.object(forKey: "PhoneNumber") ?? 0,
        "locationLatitude": Int((CLLocationManager().location?.coordinate.latitude)!),
        "locationLongitude":Int((CLLocationManager().location?.coordinate.longitude)!),
        "worker": false,
        "active": true,
//        "hours": stepper.value
        ]
        guard let url = URL(
            string: "https://dry-dawn-26797.herokuapp.com/posting"
            ) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let htttpBody = try? JSONSerialization.data(withJSONObject: parmas, options: [.fragmentsAllowed]) else {return}
        request.httpBody = htttpBody
        let session = URLSession.shared
    session.dataTask(with: request) { (data, response, e) in
            if e != nil {
                print(e!)
                let alert = UIAlertController(title: "Error", message: "An error occured error description: \(e ?? e!)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let actionTry = UIAlertAction(title: "Try Agian", style: .default) { (alert) in }
                alert.addAction(action)
                alert.addAction(actionTry)
                self.present(alert, animated: true, completion: nil) }
            else {
                if let response = response {
                    print(response)  }
                if let data = data {
                    print("posting data: \(data)")
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                    print(json)
                } catch {
                    print(error) } } }
        }.resume()
    }; @IBAction func hamburgerPressed(_ sender: Any) {
        self.view.isUserInteractionEnabled = true
        guard let sideMenu = storyboard?.instantiateViewController(identifier: "SideMenu") as? SideMenu else {return}
        sideMenu.didTapMenuType = { menuType in
               
           }
        sideMenu.modalPresentationStyle = .overCurrentContext
        sideMenu.transitioningDelegate = self
        present(sideMenu, animated: true)
    }; @IBAction func goToWeatherData(_ sender: Any) {
        let weathervc = storyboard?.instantiateViewController(identifier: "WeatherVC")
        present(weathervc!, animated: true, completion: nil)
    };
}
// MARK: -
extension MainVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
          return transition   }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition }}
