//
//  HomeUiState.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//


import Observation
import SwiftUI

@Observable
class HomeUiState {

    init(
        calories: Int,
        active: Int,
        stand: Int,
        caloriesLabel: String,
        activeLabel: String,
        standLabel: String,
        activities: [Activity],
        workouts: [Workout],
    ) {
        self.calories = calories
        self.active = active
        self.stand = stand
        self.caloriesLabel = caloriesLabel
        self.activeLabel = activeLabel
        self.standLabel = standLabel
        self.activities = activities
        self.workouts = workouts
    }

    var calories: Int = 0
    var active: Int = 0
    var stand: Int = 0
    var caloriesLabel: String = ""
    var activeLabel: String = ""
    var standLabel: String = ""
    var activities: [Activity] = []
    var workouts: [Workout] = []
}
