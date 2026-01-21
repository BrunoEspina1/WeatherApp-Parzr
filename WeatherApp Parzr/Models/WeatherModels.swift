//
//  WheaterModels.swift
//  WheaterApp Parzr
//
//  Created by Bruno Espina on 19/01/26.
//

import Foundation

struct WeatherResponse: Codable {
    let list: [ForecastItem];
    let city: City;
}

struct ForecastItem : Codable, Identifiable {
    let dt: Int
    let main: MainWeather
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String
    
    var id: Int { dt }
    
    var dateFormatted: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
    
    var temperatureFarenheit: Int {
        Int((main.temp - 273.15) * 9/5 + 32)
    }
    
    var feelsLikeFarenheit: Int {
        Int((main.feelsLike - 273.15) * 9/5 + 32)
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
    }
    
}

struct City : Codable {
    let name: String;
    let country: String;
}

struct MainWeather : Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Sys: Codable {
    let pod: String
}

