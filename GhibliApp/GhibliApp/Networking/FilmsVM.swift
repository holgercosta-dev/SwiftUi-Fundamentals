//
//  FilmsVM.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import Foundation
import Observation

@Observable
class FilmsVM {
    var films: [Film] = []
    
    func fetchFilms() async {
        let url = URL(string: "https://ghibliapi.vercel.app/films")!
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            films = try JSONDecoder().decode([Film].self, from: data)
        } catch {
            print(error)
        }
    }
}
