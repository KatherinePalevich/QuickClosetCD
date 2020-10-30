//
//  CategoryPicker.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/29/20.
//

import Foundation
import CoreData
import SwiftUI

// Use code from https://stackoverflow.com/questions/56697721/is-there-a-way-to-bind-an-optional-to-a-toggle-slider-with-swiftui 
func OptionalBinding<T>(_ binding: Binding<T?>, _ defaultValue: T) -> Binding<T> {
    return Binding<T>(get: {
        return binding.wrappedValue ?? defaultValue
    }, set: {
        binding.wrappedValue = $0
    })
}

func ??<T> (left: Binding<T?>, right: T) -> Binding<T> {
    return OptionalBinding(left, right)
}

struct OptionalToggle<Label> : View where Label : View {
    @Binding var isOn: Bool?
    var label: () -> Label

    var body: some View {
        Toggle(isOn: $isOn ?? false, label: label)
    }
}

class CategoryPickerViewModel: ObservableObject {
    typealias SaveFn = (NSSet) -> Void
    @Published var categories: [String: Bool]
    private let saveFn: SaveFn
    
    init(categories: NSSet, potentialCategories: NSSet, save: @escaping SaveFn) {
        self.categories = ["A": false, "B": true]
        self.saveFn = save
    }
    
    func save() {
        saveFn(NSSet())
    }
}

struct CategoryPicker: View {
    /// Manages the categories
    @ObservedObject var categories: CategoryPickerViewModel
    
    var body: some View {
        VStack {
            ForEach (categories.categories.keys.sorted(), id: \.self) { key in
                OptionalToggle(isOn: $categories.categories[key]) {
                    Text(key)
                }
            }
        }
        
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPicker(categories: CategoryPickerViewModel(categories: NSSet(), potentialCategories: NSSet(), save: {_ in}))
    }
}
