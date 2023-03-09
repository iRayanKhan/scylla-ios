//
//  ContentView.swift
//  scylla
//
//  Created by Rayan Khan on 2/28/23.
//
import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                        .tint(.pink)
                    Text("Home")
                        .foregroundColor(.pink)
                }
            SignView()
                .tabItem {
                    Image(systemName: "signature")
                    Text("Sign IPA")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                        .tint(.pink)
                    Text("Settings")
                        .foregroundColor(.pink)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
