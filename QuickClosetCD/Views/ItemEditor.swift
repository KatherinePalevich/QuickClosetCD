//
//  ItemEditor.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/23/20.
//

import CoreData
import SwiftUI

/// The Item editor view, designed to be the destination of
/// a NavigationLink.
struct ItemEditor: View {
    let context: NSManagedObjectContext
    /// Manages editing the player
    @ObservedObject var item: Item

    var body: some View {
      ItemForm(item: item)
            .onDisappear(perform: {
                // Ignore validation errors
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            })
    }
}
