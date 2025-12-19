//
//  Film.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import Foundation
import Playgrounds

struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    let releaseYear: String
    let score: String
    let duration: String
    let image: String
    let bannerImage: String
    let people: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people

        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }

    static var example: Film {
        return Film(
            id: "id",
            title: "title",
            description: "description",
            director: "director",
            producer: "producer",
            releaseYear: "2025",
            score: "score",
            duration: "duration",
            image: "image",
            bannerImage:
                "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
            people: []
        )
    }
}

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!

    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        try JSONDecoder().decode([Film].self, from: data)
    } catch {
        print(error)
    }
}
