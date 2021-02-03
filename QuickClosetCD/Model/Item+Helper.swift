//
//  Item+Helper.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/20/20.
//
import UIKit
import Foundation

extension Item {
    
    var wrappedName: String {
      get {
        name ?? ""
      }
      set(newValue) {
        objectWillChange.send()
        name = newValue
      }
    }
    var categoryName: String {
      get {
        let category = categories?.anyObject()as?Category
        return category?.name ?? ""
      }
      set(newValue) {
        objectWillChange.send()
        let category = Category(context: self.managedObjectContext!)
        category.name = newValue
        let categories = NSSet(object: category)
        self.categories = categories
      }
    }
    
    var categoryNames: Set<String> {
      get {
        guard let c = categories else {
            return []
        }
        let d = c as! Set<Category>
        let e = d.compactMap(\.name)
        return Set(e)
      }
      set(newValue) {
        objectWillChange.send()
        let newCategories = Set(newValue.map { name -> Category in
            let category = Category(context: self.managedObjectContext!)
            category.name = name
            return category
        })
        self.categories = newCategories as NSSet
      }
    }
    
    var computedCategoriesSortKey : String {
        let typeCategories = Set(Category.typeCategoryNames())
        let categories = Set(self.categoryNames)
        let importantCategories = categories.intersection(typeCategories)
        let unimportantCategories = categories.subtracting(typeCategories)
        return (importantCategories.sorted() + unimportantCategories.sorted()).joined(separator: ", ")
    }


    var wrappedPhoto: UIImage? {
      get {
        photo?.photo
      }
      set(newValue) {
        objectWillChange.send()
        if newValue == nil {
          photo = nil
        } else {
          photo = Photo(context: managedObjectContext!)
          photo!.photo = newValue
        }
      }
    }

}
