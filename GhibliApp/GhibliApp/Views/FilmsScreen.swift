//
//  FilmsScreen.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import SwiftUI

struct FilmsScreen: View {

    let filmsVM: FilmsVM
    let favoritesVM: FavoritesVM

    var body: some View {
        NavigationStack {
            Group {
                switch filmsVM.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .loaded(let films):
                    FilmListView(
                        films: films,
                        isFavorite: { favoritesVM.isFavorite(filmId: $0) },
                        toggleFavorite: {
                            favoritesVM.toggleFavorite(filmId: $0)
                        },
                    )
                case .error(let error):
                    Text(error)
                        .foregroundColor(Color.red)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
    }
}

#Preview {
    FilmsScreen(
        filmsVM: FilmsVM(service: MockGhibliService()),
        favoritesVM: FavoritesVM(),
    )
}
