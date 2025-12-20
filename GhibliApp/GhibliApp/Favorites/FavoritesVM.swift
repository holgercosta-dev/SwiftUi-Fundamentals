//
//  FavoritesVM.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import Foundation
import Observation

@Observable
final class FavoritesVM {

    private let favoriteStorage: FavoriteStorage

    init(favoriteStorage: FavoriteStorage = DefaultFavoriteStorage()) {
        self.favoriteStorage = favoriteStorage
    }

    private(set) var favoriteIds: Set<String> = []

    func load() {
        favoriteIds = favoriteStorage.load()
    }

    private func save() {
        favoriteStorage.save(ids: Array(favoriteIds))
    }

    func toggleFavorite(filmId: String) {
        if favoriteIds.contains(filmId) {
            favoriteIds.remove(filmId)
        } else {
            favoriteIds.insert(filmId)
        }
        
        save()
    }

    func isFavorite(filmId: String) -> Bool {
        favoriteIds.contains(filmId)
    }

}
