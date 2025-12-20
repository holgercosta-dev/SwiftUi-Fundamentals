//
//  FilmsScreen.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import SwiftUI

struct FilmsScreen: View {
    
    let viewModel: FilmsVM
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .loaded(let films):
                    FilmListView(films: films)
                case .error(let error):
                    Text(error)
                        .foregroundColor(Color.red)
                }
            }
            .navigationTitle("Ghibli Movies")
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    FilmsScreen(viewModel: FilmsVM(service: MockGhibliService()))
}
