//
//  ContentView.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/29/20.
//

import Foundation
import SwiftUI
import CoreData

struct ContentView: View {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView{
            itemListTab.tabItem{
                Image(systemName: "list.bullet")
                Text("Item List")
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
            .accentColor(Color.yellow)
            outfitGenerator.tabItem{
                Image(systemName: "faxmachine")
                Text("Outfit Generator")
            }
        }
    }
}

var itemListTab: some View {
    NavigationView {
        ItemList()
    }
}

var outfitGenerator: some View {
    NavigationView {
        OutfitGenerator()
            //.environment(\.managedObjectContext, persistenceController.container.viewContext)
            .accentColor(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().colorScheme(.light)
            ContentView().colorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        
    }
}
