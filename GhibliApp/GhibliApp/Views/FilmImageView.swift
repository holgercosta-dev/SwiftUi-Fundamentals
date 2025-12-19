//
//  FilmImageView.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import SwiftUI

struct FilmImageView: View {

    let urlPath: String

    var body: some View {
        AsyncImage(url: URL(string: urlPath)) { phase in
            switch phase {
            case .empty:
                Color(white: 0.8)
                    .overlay {
                        ProgressView()
                            .controlSize(.small)
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                Text(error.localizedDescription)
                    .foregroundColor(Color.red)
            @unknown default:
                fatalError()
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    FilmImageView(
        urlPath:
            "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg"
    )
}
