//
//  Item+Helper.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 10/20/20.
//

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
}
