//
//  futureWeather.swift
//  weatherapp
//
//  Created by Anthony Youbi Sobodker on 2017-06-13.
//  Copyright © 2017 SBS. All rights reserved.
//

import UIKit
import Alamofire

class futureWeather
{
    private var _weatherTypeFuture:String!
    private var _dateFuture:String!
    private var _currentFutureTemp: Double!
    private var _lowFutureTemp: Double!
    private var _highFutureTemp:Double!
    
    var weatherTypeFuture:String
    {
       if (_weatherTypeFuture == nil)
       {
            _weatherTypeFuture = ""
        
        }
        
        return _weatherTypeFuture
    }
    
    var dateFuture:String
    {
        if (_dateFuture == nil)
        {
            _dateFuture = ""
        }
        
        return _dateFuture
            
    }
    
    var currentFutureTemp: Double
    {
         if (_currentFutureTemp == nil)
         {
            _currentFutureTemp = 0.0
         }
        
        return _currentFutureTemp
        
    }
    
    var lowFutureTemp:Double
    {
        if (_lowFutureTemp == nil)
        {
            _lowFutureTemp = 0.0
        }
        
        return _lowFutureTemp
            
    }
    
    var highFutureTemp:Double
    {
        if (_highFutureTemp == nil)
        {
            _highFutureTemp = 0.0
        }
        
        return _highFutureTemp
            
    }
    
    init(weatherDict: Dictionary<String, AnyObject>)
    {
        for (key, value) in weatherDict
        {
            if (key == "temp")
            {
                var weatherTempDict = value as? Dictionary<String, AnyObject>
                
                for (key, value) in weatherTempDict!
                {
                    if (key == "day")
                    {
                        self._currentFutureTemp = value as? Double
                    }
                    
                    if (key ==  "min")
                    {
                        self._lowFutureTemp = value as? Double
                        
                    }
                    
                    if (key == "max")
                    {
                        self._highFutureTemp = value as? Double
                    }
                }
            }
            
            if (key == "weather")
            {
                var weatherTyeArr = value as? [Dictionary<String, AnyObject>]
                
                self._weatherTypeFuture = weatherTyeArr![0]["main"] as? String
                
            }
            
            if (key == "dt")
            {
                //total amount of seconds since 1970; unix timestamp
                var seconds = value as? Double
                var unixConvertedDate = Date(timeIntervalSince1970: seconds!)
                
                self._dateFuture = unixConvertedDate.dayOfWeek()
                
                
                
            }
            
        }
        
    }
    
    
    
    
    
}

extension Date
{
    func dayOfWeek() -> String
    {
        let dateFormat = DateFormatter()
        //These two lines are not needed when doing specific formatting involving .dateFormat
        //dateFormat.dateStyle = .full
        //dateFormat.timeStyle = .none
        dateFormat.dateFormat = "EEEE"
       
        
        //self means date object method is called on
        return dateFormat.string(from: self)
        
    }
}
