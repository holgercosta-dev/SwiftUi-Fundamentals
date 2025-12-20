//
//  FavoriteStorage.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(ids: [String])
}
