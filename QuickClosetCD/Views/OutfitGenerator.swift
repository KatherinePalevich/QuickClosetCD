//
//  OutfitGenerator.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 12/18/20.
//

import SwiftUI

let icon : [String: String] = [
    "01d" : "sun.max",
    "01n" : "sun.max.fill",
    "02d" : "cloud.sun",
    "02n" : "cloud.sun.fill",
    "03d" : "cloud",
    "03n" : "cloud.moon.fill",
    "04d" : "cloud",
    "04n" : "cloud.moon.fill",
    "09d" : "cloud.heavyrain",
    "09n" : "cloud.heavyrain.fill",
    "10d" : "cloud.drizzle",
    "10n" : "cloud.drizzle.fill",
    "11d" : "cloud.bolt.rain",
    "11n" : "cloud.bolt.rain.fill",
    "13d" : "cloud.snow",
    "13n" : "cloud.snow.fill",
    "50d" : "cloud.fog",
    "50n" : "cloud.fog.fill"
]

struct OutfitGenerator: View {
    @State private var current: Current?
    var body: some View {
        VStack {
            HStack{
                Text("\(current?.name ?? "")")
                    Text(Date().addingTimeInterval(600), style: .date)
            }.onAppear(perform: loadData)
            Image(systemName: icon[current?.weather[0].icon ?? ""] ?? "").onAppear(perform: loadData)
            Text("\(current?.weather[0].main ?? "")").onAppear(perform: loadData)
            HStack{
                Text("Temperature: \(temp)").onAppear(perform: loadData)
                Text("Feels Like: \(feelsLike)").onAppear(perform: loadData)
            }
            Text("Min/Max:  \(tempMin) / \(tempMax) ")
        }
    }
    
    private var temp : String {
        if let temp = current?.main.temp {
            let formatter = MeasurementFormatter()
            formatter.locale = Locale.current
            formatter.numberFormatter.maximumFractionDigits = 0
            let measurement = Measurement(value: temp, unit: UnitTemperature.kelvin)
            return formatter.string(from: measurement)
        }
        else {
            return "N/A"
        }
    }
    
    private var feelsLike : String {
        if let feelsLike = current?.main.feels_like {
            let formatter = MeasurementFormatter()
            formatter.locale = Locale.current
            formatter.numberFormatter.maximumFractionDigits = 0
            let measurement = Measurement(value: feelsLike, unit: UnitTemperature.kelvin)
            return formatter.string(from: measurement)
        }
        else {
            return "N/A"
        }
    }
    
    private var tempMin : String {
        if let tempMin = current?.main.temp_min {
            let formatter = MeasurementFormatter()
            formatter.locale = Locale.current
            formatter.numberFormatter.maximumFractionDigits = 0
            let measurement = Measurement(value: tempMin, unit: UnitTemperature.kelvin)
            return formatter.string(from: measurement)
        }
        else {
            return "N/A"
        }
    }
    
    private var tempMax : String {
        if let tempMax = current?.main.temp_max {
            let formatter = MeasurementFormatter()
            formatter.locale = Locale.current
            formatter.numberFormatter.maximumFractionDigits = 0
            let measurement = Measurement(value: tempMax, unit: UnitTemperature.kelvin)
            return formatter.string(from: measurement)
        }
        else {
            return "N/A"
        }
    }
    
    // Not my own code, got it from this link: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
    func loadData() {
        let current = OpenWeather.current(lat: 47.6062, lon: -122.3321, key: "91691b703a4a262e395407f03199061c")
        guard let url = URL(string: "https://" + current.path)
        else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.current = try! JSONDecoder().decode(Current.self, from: data!)
        }.resume()
    }
}

struct OutfitGenerator_Previews: PreviewProvider {
    static var previews: some View {
        OutfitGenerator()
    }
}
