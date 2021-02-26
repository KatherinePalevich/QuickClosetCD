//
//  GeneratedOutfits.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 1/23/21.
//

import CoreData
import SwiftUI

struct GeneratedOutfits: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var items: FetchedResults<Item>
    var emotion : Emotion
    var formality : Formality
    var season : Season
    
    var body: some View {
        Text("Based on the given emotion of \(emotion.description), the formality of \(formality.description), and the season of \(season.description), here are your generated outfits!")
        let outfits = generateOutfits(color: .black, formality: formality, season: season, context: moc)
        ScrollView(.horizontal) {
            HStack{
                ForEach(outfits) { outfit in
                    ScrollView(.vertical){
                        OutfitView(outfit: outfit)
                    }
                }
            }
        }
    }
}
