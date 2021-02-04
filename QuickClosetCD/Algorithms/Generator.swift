//
//  Generator.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 1/23/21.
//

import Foundation

enum Formality : Int, CaseIterable, RawRepresentable {
    case atHome
    case casual
    case workout
    case businessCasual
    case formal
    case ballroom
    var description : String {
        switch self {
        case .atHome:
            return "At Home"
        case .casual:
            return "Casual"
        case .workout:
            return "Workout"
        case .businessCasual:
            return "Business Casual"
        case .formal:
            return "Formal"
        case .ballroom:
            return "Ballroom"
        }
    }
}

enum Emotion : Int, CaseIterable, RawRepresentable {
    case veryHappy
    case happy
    case neutral
    case sad
    case verySad
    var description : String {
        switch self {
        case .veryHappy:
            return "😄"
        case .happy:
            return "🙂"
        case .neutral:
            return "😐"
        case .sad:
            return "😞"
        case .verySad:
            return "😭"
        }
    }
}

enum ItemColor : Int, CaseIterable, RawRepresentable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case black
    case white
    case grey
    case tan
    case pattern
    var description : String {
        switch self {
        case .red:
            return "Red"
        case .orange:
            return "Orange"
        case .yellow:
            return "Yellow"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        case .purple:
            return "Purple"
        case .black:
            return "Black"
        case .white:
            return "White"
        case .grey:
            return "Grey"
        case .tan:
            return "Tan"
        case .pattern:
            return "Pattern"
        }
    }
}

enum Season : Int, CaseIterable, RawRepresentable {
    case winter
    case spring
    case summer
    case fall
    var description : String {
        switch self {
        case .winter:
            return "Winter"
        case .spring:
            return "Spring"
        case .summer:
            return "Summer"
        case .fall:
            return "Fall"
        }
    }
}
