//
//  weatherCell.swift
//  weatherapp
//
//  Created by Anthony Youbi Sobodker on 2017-06-13.
//  Copyright © 2017 SBS. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    @IBOutlet weak var futureWeatherTypeImage: UIImageView!
    
    @IBOutlet weak var futureDateLabel: UILabel!
    
    @IBOutlet weak var futureWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var futureHighTempLabel: UILabel!
    
    @IBOutlet weak var futureLowTempLabel: UILabel!
    
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func updateWeatherCell(day: futureWeather, scaleFlag: Bool)
    {
        var high, low: Double?
        
        var miniWeatherType: String?
        
        high = day.highFutureTemp
        low = day.lowFutureTemp
        
        miniWeatherType = day.weatherTypeFuture + " Mini"
        
        if (scaleFlag != true)
        {
            
            high = round((high! - 273.15))
            low = round((low! - 273.15))
            
        }
        
        else
        {
            low = round(((9 / 5) * low!) - 459.67)
            high = round(((9 / 5 ) * high! - 459.67))
        }
        
      
       
        
        futureHighTempLabel.text = String (describing: high! ) + "°"
        futureLowTempLabel.text = String (describing: low!) + "°"
        futureWeatherTypeLabel.text = day.weatherTypeFuture
        futureDateLabel.text = day.dateFuture
        
        //use mini images for rain or clouds they look better 
        if (day.weatherTypeFuture == "Rain" || day.weatherTypeFuture == "Clouds")
        {
            futureWeatherTypeImage.image = UIImage(named: miniWeatherType!)
        }
        
        else
        {
            futureWeatherTypeImage.image = UIImage(named: day.weatherTypeFuture)
        }
        
        
        
        
    }
    
    


}
