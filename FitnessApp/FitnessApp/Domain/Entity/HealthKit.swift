//
//  HealthKit.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

nonisolated struct HealthKit {
    let calories: Double?
    let exercise: Double?
    let stand: Double?
    let steps: Double?
    let exerciseDurationsForCurrentWeek: [String: Int]
    let workoutData: [WorkoutData]
}
