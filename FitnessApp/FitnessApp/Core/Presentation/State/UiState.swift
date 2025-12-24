//
//  UiState.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

enum UiState<T> {
    case idle
    case loading
    case success(T)
    case error(Error)
}
