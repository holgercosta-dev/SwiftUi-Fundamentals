//
//  FavoritesScreen.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import SwiftUI

struct FavoritesScreen: View {

    let viewModel: FilmsVM
    
    var films: [Film] {
        []
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites yet", systemImage: "heart")
                } else {
                    FilmListView(films: films)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(viewModel: FilmsVM(service: MockGhibliService()))
}
