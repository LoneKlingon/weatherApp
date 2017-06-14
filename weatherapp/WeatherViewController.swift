//
//  ViewController.swift
//  weatherapp
//
//  Created by Anthony Youbi Sobodker on 2017-06-07.
//  Copyright © 2017 SBS. All rights reserved.
//

import UIKit
import Alamofire

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
    
    //array of futureweather class objects
    var forecasts = [futureWeather]()
    

    var currentWeatherData:currentWeather!
    

    //Flag to know which scale to use False = celsius, True = Fahrenheit
    var weatherFlag = false
    
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
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherViewCell", for: indexPath) as? weatherCell
        {
            cell.updateWeatherCell(day: forecasts[indexPath.row], scaleFlag: weatherFlag)
            
           return cell
        }
        
        else
        {
            return weatherCell()
        }
        
        
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
        
        //set weatherCell to celsius scale
        weatherFlag = false
        //update tableView
        tableView.reloadData()
        
      
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
        
        //set weatherCell to fahrenheit scale
        weatherFlag = true
        //update tableView
        tableView.reloadData()
        
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
    
    func downloadWeatherDataForWeatherCell(completed: @escaping downloadCompleted)
    {
        //load link details
        let weatherApi = apiData()
        
        //construct link
        let url = weatherApi.weatherStruct.BASE_URL2 + weatherApi.weatherStruct.BASE_LAT + weatherApi.weatherStruct.lat + weatherApi.weatherStruct.BASE_LON + weatherApi.weatherStruct.lon + weatherApi.weatherStruct.CNT + weatherApi.weatherStruct.days + weatherApi.weatherStruct.APP_ID + weatherApi.weatherStruct.API_KEY
        
        
        print("multi day url = " + url)
        
        //convert link text to url format
        let multiDayForecast = URL(string: url)
        
        //request JSON FROM URL
        Alamofire.request(multiDayForecast!).responseJSON
        {
            response in
            let result = response.value
            
            let resultsDict = result as? Dictionary<String, AnyObject>
            
            for (key, value) in resultsDict!
            {
                if (key == "list")
                {
                    //store entire list of forecasts
                    var daysForecastsList = value as? [Dictionary<String, AnyObject>]
                    
                    //step through the array and add it to the forecasts array of class futureWeather objs
                    
                    for day in daysForecastsList!
                    {
                        //create future weather obj
                        var forecast = futureWeather.init(weatherDict: day)
                        
                        self.forecasts.append(forecast)
                    }
                    //remove duplicate entry at 0th day (today)
                    self.forecasts.remove(at: 0)
                    
                    //reload tableview data
                    self.tableView.reloadData()
                    
                    
                }
                
            }
            completed()
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
        
        downloadWeatherDataForWeatherCell {
            //test
            print("multi day api test " + String(describing:self.forecasts[2].currentFutureTemp))
            
            //test
            print("multi day api test " + String(describing:self.forecasts[2].lowFutureTemp))
            
            //test
            print("multi day api test " + String(describing:self.forecasts[2].highFutureTemp))
            
            //test
            print("multi day api test " + self.forecasts[2].dateFuture)
           
            //test
            print("multi day api test " + self.forecasts[2].weatherTypeFuture)

        }
        
        
        
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

