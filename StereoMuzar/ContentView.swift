//
//  ContentView.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlayerScreen(viewModel: .init())
                .tabItem {
                    Image(systemName: "playpause.fill")
                    Text("Player")
                }
            
            CategoriesScreen()
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Mood")
                }
            
            SettingsScreen()
                .tabItem{
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
