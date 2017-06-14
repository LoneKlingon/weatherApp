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
    
    func updateWeatherCell(day: futureWeather)
    {
        futureHighTempLabel.text = String (describing: day.currentFutureTemp)
        futureLowTempLabel.text = String (describing: day.lowFutureTemp)
        futureWeatherTypeLabel.text = day.weatherTypeFuture
        futureWeatherTypeImage.image = UIImage(named: day.weatherTypeFuture)
        
    }
    
    


}
