//
//  Outfit.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 2/2/21.
//

import CoreData
import Foundation

func fetchItem(color: ItemColor, formality: Formality, category: String, context: NSManagedObjectContext) -> Item? {
    let itemsRequest = NSFetchRequest<Item>(entityName: "Item")
    itemsRequest.predicate = NSPredicate(format: "categoriesSortKey CONTAINS %@ AND categoriesSortKey CONTAINS %@", formality.description, category)
    let items = try! context.fetch(itemsRequest)
    return items.randomElement()
}

struct Outfit : Identifiable {
    let id = UUID()
    var color : ItemColor
    var formality : Formality
    var top : Item?
    var bottom: Item?
    var shoes : Item?
    var outerwear: Item?
    var socks : Item?
    var headwear : Item?
    var jewelry: Item?
    var accessory: Item?
    
    init (color: ItemColor, formality: Formality, context: NSManagedObjectContext){
        self.color = color
        self.formality = formality
        func fetchItem(category: String) -> Item? {
            QuickClosetCD.fetchItem(color: color, formality: formality, category: category, context: context)
        }
        top = fetchItem(category: "Top")
        bottom = fetchItem(category: "Bottom")
        shoes = fetchItem(category: "Shoes")
        outerwear = fetchItem(category: "Outerwear")
        socks = fetchItem(category: "Socks")
        headwear = fetchItem(category: "Headwear")
        jewelry = fetchItem(category: "Jewelry")
        accessory = fetchItem(category: "Accessory")
    }
    
    
}
