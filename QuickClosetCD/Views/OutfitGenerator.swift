//
//  OutfitGenerator.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 12/18/20.
//

import SwiftUI

struct OutfitGenerator: View {
    @State private var current: Current?
    var body: some View {
        Text("\(current?.name ?? "")").onAppear(perform: loadData)
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
