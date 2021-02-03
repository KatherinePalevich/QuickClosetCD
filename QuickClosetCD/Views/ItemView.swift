//
//  ItemView.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 2/2/21.
//

import SwiftUI

struct ItemView: View {
    let item : Item
    var body: some View {
        if let photo = item.wrappedPhoto {
          Image(uiImage: photo)
            .resizable()
            .cornerRadius(5)
            .scaledToFit()
            .frame(maxWidth: 120, maxHeight: 100)
        }
        if let name = item.name {
            Text(name)
        }
        
    }
}
