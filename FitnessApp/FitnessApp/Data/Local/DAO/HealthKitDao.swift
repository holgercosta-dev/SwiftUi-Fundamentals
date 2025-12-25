//
//  HealthKitDao.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

nonisolated struct HealthKitDao {
    var calories: Double?
    var exercise: Double?
    var stand: Double?
    var steps: Double?
    var exerciseDurationsForCurrentWeek: [Exercise: Int] = [:]
}

enum Exercise: String {
    case running = "running"
    case strength = "strength"
    case soccer = "soccer"
    case basketball = "basketball"
    case stairs = "stairs"
    case kickboxing = "kickboxing"
}

extension HealthKitDao {

    func toDomain() -> HealthKit {
        let dictionary = Dictionary(
            uniqueKeysWithValues: self.exerciseDurationsForCurrentWeek.map {
                (key, value) in (key.rawValue, value)
            }
        )
        return HealthKit(
            calories: self.calories,
            exercise: self.exercise,
            stand: self.stand,
            steps: self.steps,
            exerciseDurationsForCurrentWeek: dictionary
        )
    }

}
