//
//  Persistence.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/20/20.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.name = "Item \(i)"
            let category = Category(context: viewContext)
            category.name = "Category \(i)"
            var categories = NSSet(object: category)
            newItem.categories = categories
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        
        UIImageTransformer.register()
        
        container = NSPersistentContainer(name: "QuickClosetCD")
        let localContainer = container
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            //Make sure there are categories for the user to choose from
            let categoryNames = Category.allCategoryNames(context: localContainer.viewContext)
            if categoryNames.count == 0 {
                PersistenceController.createDefaultDatabase(context: localContainer.viewContext)
            }
        })
    }
    
    static func createDefaultDatabase(context: NSManagedObjectContext){
        
        //Create 5 t-shirts, 2 jeans, 1 dress shirt, 2 jackets, 1 ring, 1 necklace, 2 shorts, 2 dresses, 3 shoes
        // Name, filename, categories
        let initialDatabase = """
        Space Graphic Tee, spaceTee, Spring, Summer, Fall, Black, White, Top, At Home, Casual
        Snoopy Graphic Tee, snoopyTee, Spring, Summer, Fall, Black, White, Yellow, Top, At Home, Casual
        Seagull Graphic Tee, seagullTee, Spring, Summer, Fall, Black, White, Orange, Top, At Home, Casual, Pattern
        CoCa Cola Graphic Tee, cokeTee, Spring, Summer, Fall, White, Red, Top, At Home, Casual
        Workout Tee, workoutTee, Spring, Summer, Fall, Winter, Blue, Workout, Top
        Light Wash Jean, lightJean, Spring, Winter, Fall, Blue, Casual, Bottom
        Leather Pants, leatherPants, Winter, Fall, Brown, Casual, Business Casual, Formal, Bottom
        Blouse, blouse, Spring, Summer, Black, Pink, Business Casual, Formal, Top
        Super Puff Jacket, superPuffJacket, Winter, Fall, Blue, Purple, Business Casual, Casual, Outerwear
        Squamish Windbreaker, windbreakerJacket, Winter, Fall, Yellow, Orange, Workout, Casual, Outerwear
        Celestial Ring, ring, Winter, Fall, Summer, Spring, Yellow, Casual, Ballroom, Formal, Jewelry
        Leaf Necklace, goldNecklace, Winter, Fall, Summer, Spring, Yellow, Casual, Business Casual, Ballroom, Formal, Jewelry
        Light Denim Short, denimLightShort, Summer, Blue, Casual, At Home, Bottom
        Black Denim Short, denimBlackShort, Summer, Black, Casual, At Home, Bottom
        Emerald Dress, emeraldDress, Summer, Winter, Fall, Spring, Formal, Ballroom, Bottom, Top, Green
        Floral Dress, floralDress, Summer, Spring, Casual, Formal, Bottom, Top, White, Pattern
        Air Force 1, airforce1, Summer, Spring, Fall, Winter, Casual, White, Shoes, Grey
        Black Heels, blackHeels, Summer, Spring, Fall, Winter, Business Casual, Formal, Ballroom, Black, Shoes
        Chelsea Boots, chelseaBoots, Spring, Fall, Winter, Casual, Black, Shoes
        Blue Scrunchie, blueScrunchie, Summer, Spring, Winter, Casual, At Home, Blue, Headwear
        Running Shoes, runningShoes, Summer, Fall, Winter, Spring, Casual, Workout, White, Orange, Shoes
        Leggings, leggings, Summer, Fall, Winter, Spring, Workout, At Home, Black, Bottom
        Sweatpants, sweatpants, Spring, Fall, Winter, At Home, Casual, Workout, Bottom, Grey, White
        Sweater, sweater, Spring, Fall, Winter, At Home, Casual, Business Casual, Top, Grey, Tan
        Grey Socks, socksGrey, Spring, Summer, Fall, Winter, At Home, Casual, Workout, Socks, Grey
        """
        
        let items = initialDatabase.components(separatedBy: "\n")
        for item in items {
            let itemData = item.components(separatedBy: ", ")
            let itemName = itemData[0]
            let fileName = itemData[1]
            let uiImage = UIImage(named: fileName)!
            let photo = Photo(context: context)
            photo.photo = uiImage
            let itemObject = Item(context: context)
            itemObject.name = itemName
            itemObject.photo = photo
            let itemCategories = itemData[2..<itemData.count]
            for category in itemCategories {
                let categoryObject = Category(context: context)
                categoryObject.name = category
                itemObject.categories = (itemObject.categories?.adding(categoryObject))! as NSSet
            }
            itemObject.categoriesSortKey = itemObject.computedCategoriesSortKey
        }
        try! context.save()
    }
}

