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
                    VStack(alignment: .leading) {
                        HStack {
                            Text(film.title)
                                .bold()
                            Spacer()
                            Button {
                                toggleFavorite(film.id)
                            } label: {
                                let isFavorite = isFavorite(film.id)
                                Image(
                                    systemName: isFavorite
                                        ? "heart.fill" : "heart"
                                )
                                .foregroundColor(
                                    isFavorite ? Color.red : Color.black
                                )
                            }
                            .buttonStyle(.plain)
                            .controlSize(.large)
                        }
                        .padding(.bottom)

                        Text("Directed by \(film.director)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Released: \(film.releaseYear)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(
                film: film,
                isFavorite: isFavorite,
                toggleFavorite: toggleFavorite
            )
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
