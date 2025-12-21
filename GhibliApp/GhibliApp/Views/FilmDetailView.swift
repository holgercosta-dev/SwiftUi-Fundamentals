//
//  FilmDetailView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct FilmDetailView: View {

    let film: Film

    @State private var viewModel = FilmDetailVM()
    let isFavorite: (String) -> Bool
    let toggleFavorite: (String) -> Void

    var body: some View {
        ScrollView {
            VStack {
                FilmImageView(urlPath: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Divider()

                    Text("Characters")
                        .font(.title3)

                    switch viewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .loaded(let people):
                        ForEach(people) { person in
                            Text(person.name)
                        }
                    case .error(let error):
                        Text(error)
                            .foregroundColor(Color.red)
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    toggleFavorite(film.id)
                } label: {
                    let isFavorite = isFavorite(film.id)
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(
                            isFavorite ? Color.red : Color.black
                        )
                }
            }
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    NavigationStack {
        let film = Film.example
        FilmDetailView(film: film, isFavorite: { _ in false }, toggleFavorite: { _ in })
    }
}
