//
//  OpenWeatherAPI.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 1/10/21.
//

import Foundation

enum OpenWeather {
    case current(lat: Double, lon: Double, key: String)
    var path: String {
        switch self {
        case .current(lat: let lat, lon: let lon, key: let key):
            return "api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(key)"
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
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
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

