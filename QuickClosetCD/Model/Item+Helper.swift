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
