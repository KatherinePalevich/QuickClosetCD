//
//  Questionnaire.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 1/22/21.
//

import SwiftUI

let emotions : [String] = [
    "😄", "🙂", "😐", "😞", "😭"
]

let formality : [String] = [
    "At Home", "Casual", "Workout", "Business Casual", "Formal", "Ballroom"
]

struct Questionnaire: View {
    @Binding var selectedEmotion: Int
    @Binding var selectedFormality: Int
    var body: some View {
        Section(header: Text("Questionnaire")) {
            Section {
                Picker(selection: $selectedEmotion, label: Text("How are you feeling today?")) {
                    ForEach(0..<emotions.count){ num in
                        Text(emotions[num])
                    }
                }
            }
            Section {
                Picker(selection: $selectedFormality, label: Text("Formality?")) {
                    ForEach(0..<formality.count){ num in
                        Text(formality[num])
                    }
                }
            }
        }
    }
}
