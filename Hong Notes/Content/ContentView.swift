//
//  ContentView.swift
//  Hong Notes
//
//  Created by dtthong on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ListUserView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
