//
//  HomeUiMapper.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import SwiftUI

@Observable
class HomeUiMapper {
    func mapFrom(data: HealthKit) -> HomeUiState {
        let finalCalories = Int(data.calories ?? 0)
        let finalExercise = Int(data.exercise ?? 0)
        let finalStand = Int(data.stand ?? 0)

        return HomeUiState(
            calories: finalCalories,
            active: finalExercise,
            stand: finalStand,
            caloriesLabel: "\(finalCalories) kcal",
            activeLabel: "\(finalExercise) minutes",
            standLabel: "\(finalStand) hours"
        )
    }
}
