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
    
    var body: some View {
        ItemList()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
