//
//  GhibliService.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import Foundation

protocol GhibliService {
    func fetchFilms() async throws -> [Film]
}
