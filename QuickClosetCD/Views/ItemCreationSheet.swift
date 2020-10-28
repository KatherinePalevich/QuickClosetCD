//
//  ItemCreationSheet.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/23/20.
//
import CoreData
import SwiftUI

/// The Item creation sheet
struct ItemCreationSheet: View {
    let context: NSManagedObjectContext
    /// Manages editing of the new item
    @ObservedObject var item: Item

    /// Executed when user cancels or saves the new item.
    let dismissAction: () -> Void

    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = ""

    var body: some View {
        NavigationView {
            ItemForm(item: item)
                .alert(
                    isPresented: $errorAlertIsPresented,
                    content: { Alert(title: Text(errorAlertTitle)) })
                .navigationBarTitle("New Item")
                .navigationBarItems(
                    leading: Button(
                        action: self.dismissAction,
                        label: { Text("Cancel") }),
                    trailing: Button(
                        action: self.save,
                        label: { Text("Save") }))
        }
    }

    private func save() {
        do {
            try context.save()
            dismissAction()
        } catch {
            errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error occurred"
            errorAlertIsPresented = true
        }
    }
}
