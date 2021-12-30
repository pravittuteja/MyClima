//
//  WeatherManager.swift
//  Clima
//
//  Created by Pravit Tuteja on 29/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherProtocol {
    func didUpdateWeather (_ weatherManager : WeatherManager,weather: WeatherModel)
    func didFailWithError (error : Error)
}

struct WeatherManager {
    
    var delegate : WeatherProtocol?
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=a37d9a8fd6f39f1c169a3c2a3467e042&units=metric"
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString : String) {
        //1. Create URL
        if let url = URL(string: urlString){
            //2. Create URL Session
            let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //4. Start the Task
            
            task.resume()
        }
    }
    func handle (data : Data?, response : URLResponse? , error : Error?){
        if error != nil{
            delegate?.didFailWithError(error: error!)
            return
        }
        if let safeData = data {
            
            if let weather = parseJSON(weatherData: safeData){
                delegate?.didUpdateWeather(self, weather: weather)
                
            }
            
        }
    }
    
    func parseJSON(weatherData : Data) -> WeatherModel?{
        //1. Create JSON Decoder
        let decoder = JSONDecoder()
        //2. Decode the decodable WeatherData based on WeatherData struct
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
