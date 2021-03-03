//
//  WelcomeView.swift
//  QuickClosetCD
//
//  Created by Katherine Palevich on 3/2/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to QuickCloset").font(.largeTitle)
            Text("Please select a clothing item in the left-hand menu; swipe from left edge to show it.").foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
