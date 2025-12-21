//
//  FavoritesScreen.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import SwiftUI

struct FavoritesScreen: View {

    let filmsVM: FilmsVM
    let favoritesVM: FavoritesVM

    var films: [Film] {
        let favorites = favoritesVM.favoriteIds
        return filmsVM.films.filter { favorites.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites yet",
                        systemImage: "heart"
                    )
                } else {
                    FilmListView(
                        films: films,
                        isFavorite: { favoritesVM.isFavorite(filmId: $0) },
                        toggleFavorite: {
                            favoritesVM.toggleFavorite(filmId: $0)
                        },
                    )
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsVM: FilmsVM(service: MockGhibliService()),
        favoritesVM: FavoritesVM()
    )
}
