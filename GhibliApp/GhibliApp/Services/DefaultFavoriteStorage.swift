//
//  DefaultFavoriteStorage.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import Foundation

struct DefaultFavoriteStorage: FavoriteStorage {
    
    private let favoritesKey = "GhibliExplorer.FavoriteFilms"
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return Set(array)
    }
    
    func save(ids: [String]) {
        UserDefaults.standard.set(ids, forKey: favoritesKey)
    }
    
}
