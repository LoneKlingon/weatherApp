//
//  currentWeather.swift
//  weatherapp
//
//  Created by Anthony Youbi Sobodker on 2017-06-10.
//  Copyright © 2017 SBS. All rights reserved.
//

import UIKit
import Alamofire

class currentWeather
{
    
    private var _city:String!
    private var _date:String!
    private var _weatherType:String!
    private var _country:String!
    private var _currentTemp:Double!
    private var _lowTemp:Double!
    private var _highTemp:Double!
    
    
    var city:String
    {
        get
        {
            if (_city == nil)
            {
                _city = ""
            }
            
            return _city
        }
        
        set
        {
            if (newValue != nil && newValue != "")
            {
                _city = newValue
            }

        }
        
    }
    
    var date:String
    {
        get
        {
            if (_date == nil)
            {
                _date = ""
            }
            
            var dateFormat = DateFormatter()
            
            dateFormat.dateStyle = .long
            dateFormat.timeStyle = .none
            
            var currentDate = dateFormat.string(from: Date())
            print ("current date: " + currentDate)
            
            _date = "Today, " + currentDate
            
            return _date
        }
        
        
    }

    
    
    var weatherType:String
    {
        get
        {
            if (_weatherType == nil)
            {
                _weatherType = ""
            }
            
            return _weatherType
        }
        
    
    }
    
    var country: String
    {
        if (_country == nil)
        {
            _country = ""
        }
 
        return _country
    }
    
    
    var currentTemp:Double
    {
        get
        {
            if (_currentTemp == nil)
            {
                _currentTemp = 0.0
            }
            
            return _currentTemp
        }
        
        
    }
    
    var lowTemp:Double
    {
        get
        {
            if (_lowTemp == nil)
            {
                _lowTemp = 0.0
            }
            
            return _lowTemp
        }
        
        set
        {
            if (newValue != nil)
            {
                _lowTemp = newValue
            }
            
        }
        
    }
    
    var highTemp:Double
    {
        get
        {
            if (_highTemp == nil)
            {
                _highTemp = 0.0
            }
            
            return _highTemp
        }
        
        set
        {
            if (newValue != nil)
            {
                _highTemp = newValue
            }
            
        }
        
    }
    
    
    func downloadWeatherData(completed: @escaping downloadCompleted)
    {
        //load link details
        let weatherApi = apiData()
        
        //construct link
        let url = weatherApi.weatherStruct.BASE_URL + weatherApi.weatherStruct.BASE_LAT + weatherApi.weatherStruct.lat + weatherApi.weatherStruct.BASE_LON + weatherApi.weatherStruct.lon + weatherApi.weatherStruct.APP_ID + weatherApi.weatherStruct.API_KEY
        
        //convert link text to url format
        let currentWeatherUrl = URL(string: url)
        
        //request JSON FROM URL
        Alamofire.request(currentWeatherUrl!).responseJSON
        {
            response in
            let result = response.result
            //result stores the JSON Data of the URL
            print (result.value)
            
            //stores the json data as a dictionary key value will always be string
            var dict = result.value as? Dictionary<String, AnyObject>
           
            //for each to walk through dictionary
            for (key, value) in dict!
            {
                if (key == "name")
                {
                    self._city = String(describing: value)
                    print(self._city)
                    
                    
                }
                
                if (key == "weather")
                {
                    var weatherInfo = value as? [Dictionary<String, AnyObject>]
                    
                    self._weatherType = String (describing: weatherInfo![0]["main"]!)
                
                    print (self._weatherType)
                    
                }
                
                if (key == "main")
                {
                    var dict2 = value as? Dictionary<String, AnyObject>
                    
                    for (key, value) in dict2!
                    {
                        if (key == "temp")
                        {
                            self._currentTemp = value as? Double
                            
                            print (self._currentTemp)
                        }
                        
                        if (key == "temp_min")
                        {
                            self._lowTemp = value as? Double
                            
                            print (self._lowTemp)
                        }
                        
                        if (key == "temp_max")
                        {
                            self._highTemp = value as? Double
                            
                            print (self._highTemp)
                        }
                        
                    }
                    
                }
                
                if (key == "sys")
                {
                    let dict3 = value as? Dictionary<String, AnyObject>
                    
                    for (key, value) in dict3!
                    {
                        if (key == "country")
                        {
                            self._country = value as? String
                            print("country =: " + self._country)
                        }
                    }
                    
                }
                
                
                
                
                
            }
            //name of argument in func call this when done points to the typealias function in apiData
            completed()//must be within Alamofire json request closure
        }
        
        
        
        
        
        
        
    }
    
    func printTest()
    {
        print (_city)
    }
    
    
    
    
    
}
