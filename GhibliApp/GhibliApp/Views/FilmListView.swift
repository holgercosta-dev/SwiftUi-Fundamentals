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
                Text("No films yet")
            case .loading:
                Text("Loading...")
            case .loaded(let array):
                List(array) { film in
                    Text(film.title)
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
