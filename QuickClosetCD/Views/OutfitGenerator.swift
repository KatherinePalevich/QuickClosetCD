//
//  OutfitGenerator.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 12/18/20.
//

import SwiftUI

struct OutfitGenerator: View {
    @State private var current: Current?
    @State private var forecast: Forecast?
    @State private var selectedEmotion = 0
    @State private var selectedFormality = 0
    var season : Season {
        let month = getMonth(dt: Date())
        //determined based on the fact that people like to dress ahead of the season
        if month < 3 || month == 12 {
            return Season.winter
        } else if month < 6 {
            return Season.spring
        } else if month < 9 {
            return Season.summer
        } else {
            return Season.fall
        }
    }
    
    var body: some View {
            Form {
//                WeatherReport(current: $current,
//                              forecast: $forecast)
                Questionnaire(selectedEmotion: $selectedEmotion, selectedFormality: $selectedFormality)
                NavigationLink(destination:
                                GeneratedOutfits(emotion: Emotion(rawValue: selectedEmotion)!,
                                                 formality: Formality(rawValue: selectedFormality)!,
                                                 season: season
                                )) {
                    Text("Generate Outfits!")
                         }.buttonStyle(PlainButtonStyle())
            }//.border(Color.blue)
            .navigationBarTitle("Outfit Generator")
            .onAppear {
                loadDataCurrent()
                // The API subscription expired.
                //loadDataForecast()
            }
    }
    
    // Not my own code, got it from this link: https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
    func loadDataCurrent() {
        let current = OpenWeather.current(lat: 47.6062, lon: -122.3321, key: "91691b703a4a262e395407f03199061c")
        guard let url = URL(string: "https://" + current.path)
        else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.current = try! decoder.decode(Current.self, from: data!)
        }.resume()
    }
    
    func loadDataForecast() {
        let forecast = OpenWeather.forecast(lat: 47.6062, lon: -122.3321, key: "91691b703a4a262e395407f03199061c")
        guard let url = URL(string: "https://" + forecast.path)
        else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.forecast = try! decoder.decode(Forecast.self, from: data!)
        }.resume()
    }
    
    func getMonth(dt : Date) -> Int {
        var monthDate = dt.description.prefix(7)
        monthDate = monthDate.suffix(2)
        return Int(monthDate) ?? 0
    }

}

struct OutfitGenerator_Previews: PreviewProvider {
    static var previews: some View {
        OutfitGenerator()
    }
}
