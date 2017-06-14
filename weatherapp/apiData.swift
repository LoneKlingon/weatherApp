//
//  apiData.swift
//  weatherapp
//
//  Created by Anthony Youbi Sobodker on 2017-06-09.
//  Copyright © 2017 SBS. All rights reserved.
//

import Foundation

//this is like a constant can go anywhere
typealias downloadCompleted = () -> ()

class apiData
{
    
    struct urlData
    {
        let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
        
        let BASE_LAT = "lat="
        
        let BASE_LON = "&lon="
        
        let APP_ID = "&appid="
        
        let API_KEY = "b8da14fa6519bc0e735d2d0a9df97b26"
        
        var lon = "55.48"
        
        var lat = "-20.89"
        
        
        //used for multi day forecast
        let BASE_URL2 = "http://api.openweathermap.org/data/2.5/forecast/daily?"
        
        //weather forecast day count
        let CNT = "&cnt="
        
        //amount of days to have forecast api max is 16
        var days = "7"
        
        
    }
    

    
    
//use this to create a function to call the urlData struct in other files 
    var weatherStruct = urlData()
    

    
    
}
    
    
    
