//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct FilmListView: View {
    
    let films: [Film]
    let isFavorite: (String) -> Bool
    let toggleFavorite: (String) -> Void

    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                HStack {
                    FilmImageView(urlPath: film.image)
                        .frame(width: 100, height: 150)
                    Text(film.title)
                    Button {
                        toggleFavorite(film.id)
                    } label: {
                        Image(systemName: isFavorite(film.id) ? "heart.fill" : "heart")
                    }
                }
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(film: film)
        }
    }
}

//#Preview {
//    FilmListView()
//}

//#Preview {
//    let data = try? MockGhibliService().fetchFilms()
//    FilmListView(films: data ?? [])
//}
