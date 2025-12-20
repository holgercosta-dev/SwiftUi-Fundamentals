//
//  ContentView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filmsVM = FilmsVM()
    @State private var favoritesVM = FavoritesVM()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsVM: filmsVM, favoritesVM: favoritesVM)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsVM: filmsVM, favoritesVM: favoritesVM)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
        .task {
            favoritesVM.load()
        }
    }
}

#Preview {
    ContentView()
}
