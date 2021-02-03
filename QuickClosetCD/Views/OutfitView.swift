//
//  OutfitView.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 2/2/21.
//

import SwiftUI

struct OutfitView: View {
    let outfit : Outfit
    var body: some View {
        VStack {
            if let top = outfit.top {
                ItemView(item: top)
            }
            if let bottom = outfit.bottom {
                ItemView(item: bottom)
            }
            if let shoes = outfit.shoes {
                ItemView(item: shoes)
            }
            if let outerwear = outfit.outerwear {
                ItemView(item: outerwear)
            }
            if let socks = outfit.socks {
                ItemView(item: socks)
            }
            if let socks = outfit.socks {
                ItemView(item: socks)
            }
            if let headwear = outfit.headwear {
                ItemView(item: headwear)
            }
            if let jewelry = outfit.jewelry {
                ItemView(item: jewelry)
            }
            if let accessory = outfit.accessory {
                ItemView(item: accessory)
            }
        }
    }
}
