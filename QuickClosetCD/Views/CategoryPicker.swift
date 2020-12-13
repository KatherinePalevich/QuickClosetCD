//
//  CategoryPicker.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/29/20.
//

import Foundation
import SwiftUI

///This is a picker for the categories. It will display in a sorted list the possible categories and if they have been toggled already.
struct CategoryPicker<Label> : View where Label : View {
    //@Binding is shorthand
    @Binding var selection : Set<String>
    private var categoryGroups: CategoryGroups
    private let label: (String) -> Label
    
    init(selection: Binding<Set<String>>, categoryGroups: CategoryGroups, @ViewBuilder label: @escaping (String) -> Label) {
        //The underscore is to put the binding into the binding
        self._selection = selection
        self.categoryGroups = categoryGroups
        self.label = label
    }
    
    var body: some View {
        Form {
            ForEach(categoryGroups, id: \.name) { categoryGroup in
                Section(header: Text(categoryGroup.name)){
                    let selectedCategories = categoryGroup.categories.compactMap{category in
                        selection.contains(category) ? category : nil
                    }.joined(separator: ", ")
                    DisclosureGroup(selectedCategories) {
                        ForEach(categoryGroup.categories, id:\.self){ category in
                            Toggle(isOn: Binding(
                                get: {
                                    selection.contains(category)
                                },
                                set: { on in
                                    if on {
                                        selection.insert(category)
                                    } else {
                                        selection.remove(category)
                                    }
                                }
                            )) {
                                label(category)
                            }
                        }
                    }
                }
            }
        }.navigationTitle("Categories")
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    //Call CategoryPicker with a given binding.
    struct CategoryPickerWrapper : View {
        @State private var selection = Set<String>(["Top"])
        var body: some View {
            CategoryPicker(selection: $selection, categoryGroups: CategoryGroup.allCategoryGroups){
                Text($0)
            }
        }
    }
    static var previews: some View {
        CategoryPickerWrapper()
    }
}
