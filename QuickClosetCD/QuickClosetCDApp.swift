//
//  QuickClosetCDApp.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/20/20.
//

import SwiftUI

@main
struct QuickClosetCDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ItemList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .accentColor(Color.yellow)
        }
    }
}
