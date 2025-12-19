//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct FilmListView: View {
    @State var filmsViewModel = FilmsVM()

    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let array):
                List(array) { film in
                    NavigationLink(value: film) {
                        HStack {
                            FilmImageView(urlPath: film.image)
                                .frame(width: 100, height: 150)
                            Text(film.title)
                        }
                    }
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailView(film: film)
                }
            case .error(let error):
                Text(error)
                    .foregroundColor(Color.red)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

//#Preview {
//    FilmListView()
//}

#Preview {
    @State @Previewable var vm = FilmsVM(service: MockGhibliService())
    FilmListView(filmsViewModel: vm)
}
