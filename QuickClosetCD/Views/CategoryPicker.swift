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
    private var choices: [String]
    private let label: (String) -> Label
    
    init(selection: Binding<Set<String>>, choices: Set<String>, @ViewBuilder label: @escaping (String) -> Label) {
        //The underscore is to put the binding into the binding
        self._selection = selection
        //We want to display the choices in sorted order so we call the sorted() method to sort the Array
        self.choices = Array(choices).sorted()
        self.label = label
    }
    
    var body: some View {
        List(choices, id:\.self){ choice in
            Toggle(isOn: Binding(
                    get: {
                        selection.contains(choice)
                    },
                    set: { on in
                        if on {
                            selection.insert(choice)
                        } else {
                            selection.remove(choice)
                        }
                    }
            )) {
                label(choice)
            }
            
        }

    }
}
struct CategoryPicker_Previews: PreviewProvider {
    //Call CategoryPicker with a given binding.
    struct CategoryPickerWrapper : View {
        @State private var selection = Set<String>(["Top"])
        var body: some View {
            CategoryPicker(selection: $selection, choices: ["Top", "Accessory"]){
                Text($0)
            }
        }
    }
    static var previews: some View {
        CategoryPickerWrapper()
    }
}
