//
//  OpenWeatherAPI.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 1/10/21.
//

import Foundation

enum OpenWeather {
    case current(lat: Double, lon: Double, key: String)
    case forecast(lat: Double, lon: Double, key: String)
    var path: String {
        switch self {
        case .current(lat: let lat, lon: let lon, key: let key):
            return "api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)"
        case .forecast(lat: let lat, lon: let lon, key: let key):
            return "pro.openweathermap.org/data/2.5/forecast/hourly?lat=\(lat)&lon=\(lon)&appid=\(key)"
        }
    }
}

struct Current: Codable {
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    let coord: Coord
    
    struct Weather: Codable, Identifiable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    let weather: [Weather]
    
    let base: String
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
    }
    let main: Main
    
    let visibility: Int
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    let wind: Wind
    
    struct Clouds: Codable {
        let all: Int
    }
    let clouds: Clouds
    
    let dt: Date
    
    struct Sys: Codable {
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Date
    let sunset: Date
    }
    
    let timezone: Date
    let id: Int
    let name: String
    let cod: Int
}

struct Forecast: Codable {
    struct Main: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Double
        let seaLevel: Double
        let grndLevel: Double
        let humidity: Int
        let tempKf: Double
    }
    
    struct Weather: Codable, Identifiable {
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
        let deg: Double
    }
    
    struct ListItem: Codable {
        let dt: Date
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let dtTxt: String
        let pop: Double
    }
    let list: [ListItem]
    
    struct Coord: Codable {
        let lat: Double
        let lon: Double
    }
    
    struct City: Codable, Identifiable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
    }
    let city: City
}




