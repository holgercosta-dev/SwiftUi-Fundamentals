//
//  ContentView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filmsVM = FilmsVM()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(viewModel: filmsVM)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(viewModel: filmsVM)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
