
//  WeatherVC.swift
//  Servery
//  Created by jason Moses on 2019/10/13.
//  Copyright © 2019 jason Moses. All rights reserved.
import Foundation
import UIKit
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON
class WeatherVC: UIViewController , CLLocationManagerDelegate{
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var rainLbl: UILabel!
    let weatherDataModel = WeatherDataModel()
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "ae2e13d466c4c44a20f2829b9bc0ee43"
    let parmas = [String:String]()
    let locationManger = CLLocationManager()
    override func viewDidLoad() {
        print("In View controller")
        let date = Date()
        let locale = Locale.self
        let h = locale.current.calendar.component(.hour, from: date)
             if h >= 0 && h < 12 {
                print("good morning")
                imageView.image = UIImage(named: "ServeryWeatherMorning")}
            else if h >= 12 && h < 18 {
                imageView.image = UIImage(named: "ServeryWeatherAfternoon")
                print("good afternoon")}
            else if h >= 18 && h <= 24  {
                print("good evening")
                imageView.image = UIImage(named: "ServeryWeatherEvening")}
            else {print("😦")}
        countryLbl.text = locale.current.regionCode
        overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        if CLLocationManager.locationServicesEnabled() == true {
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManger.startUpdatingLocation()
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestAlwaysAuthorization()
        }};
        
        func getWeatherData(url: String, parameters: [String: String]) {
            
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
                response in
                if response.result.isSuccess {
                    
                    print("Success! Got the weather data")
                    let weatherJSON : JSON = JSON(response.result.value!)
                    
                    
                    print(weatherJSON)
                    
                    self.updateWeatherData(json: weatherJSON)
                    
                }
                else {
                    print("Error \(String(describing: response.result.error))")
                    self.cityLbl.text = "Connection Issues"
                }}};   func updateWeatherData(json : JSON) {
            let tempResult = json["main"]["temp"].doubleValue
                weatherDataModel.temperature = Int(tempResult - 273.15)
                weatherDataModel.city = json["name"].stringValue
                weatherDataModel.condition = json["weather"][0]["id"].intValue
                    conditionLbl.text =  weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
                    weatherDataModel.humidity = "humidity: " + json["main"]["humidity"].stringValue + "%"
                    rainLbl.text = weatherDataModel.humidity
                    print(weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition))
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
                updateUIWithWeatherData()
            }
        func updateUIWithWeatherData() {
            cityLbl.text = weatherDataModel.city
            tempLbl.text = "\(weatherDataModel.temperature)° C"
            conditionImageView.image = UIImage(named: weatherDataModel.weatherIconName)
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[locations.count - 1]
            if location.horizontalAccuracy > 0 {
                self.locationManger.stopUpdatingLocation()
                print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
                let latitude = String(location.coordinate.latitude)
                let longitude = String(location.coordinate.longitude)
                let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
                getWeatherData(url: WEATHER_URL, parameters: params)
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
            cityLbl.text = "Location Unavailable"
        }
        func userEnteredANewCityName(city: String) {
            let params : [String : String] = ["q" : city, "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    @IBAction func cancelVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
