//
//  WeatherReport.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 1/22/21.
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

extension Forecast.Wind {
    var windSpeed : String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.numberFormatter.maximumFractionDigits = 0
        let measurement = Measurement(value: speed, unit: UnitSpeed.knots)
        return formatter.string(from: measurement)
    }
    
}

extension Forecast.ListItem {
    var hour : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: dt)
    }
}

extension Forecast.ListItem {
    var precipProb : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: pop))!
    }
}

extension Forecast.ListItem {
    var tempMaxF : String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.numberFormatter.maximumFractionDigits = 0
        let measurement = Measurement(value: main.tempMax, unit: UnitTemperature.kelvin)
        return formatter.string(from: measurement)
    }
}

struct WeatherReport: View {
    @Binding var current: Current?
    @Binding var forecast: Forecast?
    var body: some View {
        Section(header: Text("Weather")) {
            realBody.foregroundColor(Color.white)
                .background(Color(UIColor(hue: 200.0/360.0, saturation: 0.44, brightness: 0.8, alpha: 1)))
                .cornerRadius(25)
                .padding()
        }
    }
    
    private var realBody : some View {
        VStack{
            Text("\(current?.name ?? "")").font(.largeTitle)
            Text(Date().addingTimeInterval(600), style: .date)
            Image(systemName: icon[current?.weather[0].icon ?? ""] ?? "")
                .imageScale(.large)
            Text("\(current?.weather[0].main ?? "")")
            Text(currTemp).font(.title)
            Text("Feels Like: \(feelsLike)")
            Text("Min/Max:  \(tempMin) / \(tempMax) ")
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    if let forecast = forecast {
                        ForEach(forecast.list[...12], id: \.dt) { listItem in
                            VStack {
                                Text(listItem.hour)
                                Image(systemName: icon[listItem.weather.first!.icon]!)
                                    .renderingMode(.original)
                                    .frame(height: 30)
                                Text(listItem.tempMaxF)
                                Text(listItem.precipProb)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity)
            }.padding()
        }
    }
    
    private var currTemp : String {
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
        if let feelsLike = current?.main.feelsLike {
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
        if let tempMin = current?.main.tempMin {
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
        if let tempMax = current?.main.tempMax {
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
    
}
