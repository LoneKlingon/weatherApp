//
//  ViewController.swift
//  weatherapp
//
//  Created by Anthony Youbi Sobodker on 2017-06-07.
//  Copyright © 2017 SBS. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentDateLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var weatherTypeLabel: UILabel!
    
    @IBOutlet weak var currentDayHighLbl: UILabel!
    
    @IBOutlet weak var currentDayLowLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var weatherTypeImage: UIImageView!
    
    
    var temp: Int!
    
    var cityName: String?
    var weatherType: String?
    var todayDate: String?
    var country: String?
    var currentTemp: Double?
    var lowTemp: Double?
    var highTemp: Double?
    
    
    
    var currentWeatherData:currentWeather!
    
    
    
    @IBAction func celsiusBtnPressed(_ sender: Any)
    {
        kelvinToCelsius()
    }
    
    
    @IBAction func fahrenheitBtnPressed(_ sender: Any)
    {
        kelvinToFahrenheit()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherViewCell", for: indexPath)
        return cell
    }
     //magically updates with the right values later on refer to updateUi for the detailed info of how this all works
    func kelvinToCelsius()
    {
        var current, low, high: Double
        
        current = currentTemp!
        low = lowTemp!
        high = highTemp!
        
        
        //conversion to celsius
        current = round((current - 273.15))
        low = round((low - 273.15))
        high = round((high - 273.15))
        
        //display to ui
        currentTemperatureLabel.text = String(describing: current) + "°"
        currentDayLowLbl.text = String(describing: low ) + "°"
        currentDayHighLbl.text = String(describing: high) + "°"
        
      
    }
    
    //magically updates with the right values later on refer to updateUi for the detailed info of how this all works
    func kelvinToFahrenheit()
    {
        var current, low, high: Double
        
        current = currentTemp!
        low = lowTemp!
        high = highTemp!
        
        //conversion to fahrenheit
        current = round(((9 / 5) * current) - 459.67)
        low = round(((9 / 5) * low) - 459.67)
        high = round(((9 / 5 ) * high - 459.67))
        
        
        
        //display to ui
        currentTemperatureLabel.text = String(describing: current) + "°"
        currentDayLowLbl.text = String(describing: low ) + "°"
        currentDayHighLbl.text = String(describing: high) + "°"
    }
    
    func updateMainUI()
    {
        
  
        
        //download current weather data put initial runtime code in here or else it won't work
        currentWeatherData.downloadWeatherData
        {
            
            //gets json data from downloadWeatherData function in 
            self.cityName = self.currentWeatherData.city
            self.weatherType = self.currentWeatherData.weatherType
            self.country = self.currentWeatherData.country
            self.currentTemp = self.currentWeatherData.currentTemp
            self.lowTemp = self.currentWeatherData.lowTemp
            self.highTemp = self.currentWeatherData.highTemp
            self.todayDate = self.currentWeatherData.date
            
            //converts kelvin to celsius
            var current, low, high: Double
            current = self.currentTemp!
            low = self.lowTemp!
            high = self.highTemp!
            current = round((current - 273.15))
            low = round((low - 273.15))
            high = round((high - 273.15))
            
            
            
            //format city to CityName, CountryCode format
            self.cityName = self.cityName! + ", " + self.country!
            
        
            
            //display to ui
            self.currentTemperatureLabel.text = String(describing: current) + "°"
            self.currentDayLowLbl.text = String(describing: low) + "°"
            self.currentDayHighLbl.text = String(describing: high) + "°"
            self.locationLabel.text = self.cityName
            self.weatherTypeLabel.text = self.weatherType
            self.currentDateLabel.text = self.todayDate
            
            self.weatherTypeImage.image = UIImage(named:  self.weatherType!)
            
        
        
        }
        
        
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self 
      
        currentWeatherData = currentWeather ()
        
        //weather api resource link
        var api = apiData()
        
        var url = api.weatherStruct.BASE_URL + api.weatherStruct.BASE_LAT + api.weatherStruct.lat + api.weatherStruct.BASE_LON + api.weatherStruct.lon + api.weatherStruct.APP_ID + api.weatherStruct.API_KEY
        
        
        print(url)
   
        
        updateMainUI()
        
        
        
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

