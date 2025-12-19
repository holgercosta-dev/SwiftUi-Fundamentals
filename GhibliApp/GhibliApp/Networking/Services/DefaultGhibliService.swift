//
//  DefaultGhibliService.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import Foundation

struct DefaultGhibliService: GhibliService {
    func fetchFilms() async throws -> [Film] {
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResonse = response as? HTTPURLResponse,
                (200...299).contains(httpResonse.statusCode)
            else { throw APIError.invalidResponse }

            return try JSONDecoder().decode([Film].self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
