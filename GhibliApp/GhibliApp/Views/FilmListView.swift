//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct FilmListView: View {
    @State private var filmsViewModel = FilmsVM()
    
    var body: some View {
        List(filmsViewModel.films) { film in
            Text(film.title)
        }
        .task {
            await filmsViewModel.fetchFilms()
        }
    }
}

#Preview {
    FilmListView()
}
