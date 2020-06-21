//
//  ContentView.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedView = 1
    
    var body: some View {
        TabView(selection: $selectedView) {
            NavigationView {
                VehicleFilterView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "calendar.badge.plus")
                Text("Reserve")
            }.tag(1)
            
            Text("Not implemented").tabItem {
                Image(systemName: "calendar")
                Text("My rentals")
            }.tag(2)
            
            Text("Not implemented").tabItem {
                Image(systemName: "tray.and.arrow.down.fill")
                Text("Notifications")
            }.tag(3)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
