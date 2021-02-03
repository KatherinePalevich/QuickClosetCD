//
//  Categories+Helper.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 11/7/20.
//

import Foundation
import CoreData

extension Category {
    // Returns all categories
    static func allCategories(context: NSManagedObjectContext) -> [Category] {
        let categoriesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        
        do {
            let fetchedCategories = try context.fetch(categoriesFetch) as! [Category]
            return fetchedCategories
        } catch {
            fatalError("Failed to fetch categories: \(error)")
        }

    }
    
    static func allCategoryNames(context: NSManagedObjectContext) -> [String] {
        allCategories(context: context).compactMap(\.name)
    }
    
    static func typeCategoryNames() -> [String]{
        return ["Top", "Bottom", "Headwear", "Jewelry", "Accessory", "Shoes", "Socks", "Outerwear"]
    }
}
