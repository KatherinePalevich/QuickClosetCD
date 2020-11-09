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
    typealias SaveFn = (Set<String>) -> Void
    /// Key is the category name and value is whether it has been chosen or not by the user.
    @Published var categories: [String: Bool]
    private let saveFn: SaveFn
    
    init(chosenCategories: Set<String>, potentialCategories: Set<String>, save: @escaping SaveFn) {
        self.saveFn = save
        self.categories = [String: Bool]()
        for potentialCategory in potentialCategories {
            self.categories[potentialCategory] = chosenCategories.contains(potentialCategory)
        }
    }
    
    func save() {
        saveFn(Set(categories.compactMap{ categoryName, isChosen in
            if isChosen {
                return categoryName
            } else {
                return nil
            }
        }))
    }
}

struct CategoryPicker: View {
    /// Manages the chosenCategories
    @ObservedObject var chosenCategories: CategoryPickerViewModel
    
    var body: some View {
        VStack {
            ForEach (chosenCategories.categories.keys.sorted(), id: \.self) { key in
                OptionalToggle(isOn: $chosenCategories.categories[key]) {
                    Text(key)
                }
            }
        }
        
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPicker(chosenCategories: CategoryPickerViewModel(chosenCategories: Set(["Top"]), potentialCategories: Set(["Top", "Accessory"]), save: {_ in}))
    }
}
