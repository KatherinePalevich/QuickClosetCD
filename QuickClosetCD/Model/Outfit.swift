//
//  Outfit.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 2/2/21.
//

import CoreData
import Foundation

func fetchItems(color: ItemColor, formality: Formality, category: String, season: Season, context: NSManagedObjectContext) -> [Item] {
    let itemsRequest = NSFetchRequest<Item>(entityName: "Item")
    itemsRequest.predicate = NSPredicate(format: "categoriesSortKey CONTAINS %@ AND categoriesSortKey CONTAINS %@ AND categoriesSortKey CONTAINS %@", formality.description, category, season.description)
    let items = try! context.fetch(itemsRequest)
    return items
}

struct Outfit : Identifiable {
    let id = UUID()
    var color : ItemColor
    var formality : Formality
    var top : Item?
    var bottom: Item?
    var socks : Item?
    var shoes : Item?
    var outerwear: Item?
    var headwear : Item?
    var jewelry: Item?
    var accessory: Item?
}

func generateOutfits(color: ItemColor, formality: Formality, season: Season, context: NSManagedObjectContext) -> [Outfit] {
    func fetchItems(category: String) -> [Item] {
        QuickClosetCD.fetchItems(color: color, formality: formality, category: category, season: season, context: context)
    }
    let tops = fetchItems(category: "Top")
    let bottoms = fetchItems(category: "Bottom")
    let socks = fetchItems(category: "Socks")
    let shoes = fetchItems(category: "Shoes")
    let outerwears = fetchItems(category: "Outerwear")
    let headwear = fetchItems(category: "Headwear")
    let jewelry = fetchItems(category: "Jewelry")
    let accessories = fetchItems(category: "Accessory")
    return tops.map { top in
        Outfit(
            color: color,
            formality: formality,
            top: top,
            bottom: bottoms.randomElement(),
            socks: socks.randomElement(),
            shoes: shoes.randomElement(),
            outerwear: outerwears.randomElement(),
            headwear: headwear.randomElement(),
            jewelry: jewelry.randomElement(),
            accessory: accessories.randomElement()
        )
        
    }
}
