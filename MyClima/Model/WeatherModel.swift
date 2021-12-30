//
//  WeatherModel.swift
//  Clima
//
//  Created by Pravit Tuteja on 30/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionID : Int
    let cityName : String
    let temperature : Double
    
    var temperatureString : String {
        
        return String (format: "%0.1f" , temperature )
    }
    // Computed Property : Gets value after computing lines in the curly braces!
    var conditionName : String {
        
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }

    }
}
