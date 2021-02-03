//
//  CategoryGroup.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 11/22/20.
//

import Foundation

struct CategoryGroup {
    var name: String
    var categories: [String]
}

typealias CategoryGroups = [CategoryGroup]

extension CategoryGroup {
    static var allCategoryGroups: CategoryGroups = [
        CategoryGroup(name: "Season", categories: ["Spring", "Summer", "Autumn", "Winter"]),
        CategoryGroup(name: "Color(s)", categories: ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Black", "White", "Grey", "Tan", "Pattern"]),
        CategoryGroup(name: "Type", categories: ["Top", "Bottom", "Headwear", "Jewelry", "Accessory", "Shoes", "Socks", "Outerwear"]),
        CategoryGroup(name: "Formality", categories: ["At Home", "Casual", "Workout", "Business Casual", "Formal", "Ballroom"])
    ]
}
