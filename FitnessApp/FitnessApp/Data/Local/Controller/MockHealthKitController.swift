//
//  MockHealthKitController.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

struct MockHealthKitController: HealthKitControllerProtocol {
    func fetch(type: HealthDataType) async -> DataResult<
        HealthKitDao, any Error
    > {
        let mockDao = HealthKitDao(
            calories: 111,
            exercise: 222,
            stand: 123,
            steps: 123,
            exerciseDurationsForCurrentWeek: [
                Exercise.running : 123,
                Exercise.strength : 123,
                Exercise.soccer : 123,
                Exercise.stairs : 123,
                Exercise.basketball : 123,
                Exercise.kickboxing : 123,
            ],
            workoutData: [
                WorkoutDataDao(type: 0, duration: 123, startDate: Date(), energyBurned: 12345),
                WorkoutDataDao(type: 1, duration: 123, startDate: Date(), energyBurned: 12345),
                WorkoutDataDao(type: 3, duration: 123, startDate: Date(), energyBurned: 12345),
                WorkoutDataDao(type: 4, duration: 123, startDate: Date(), energyBurned: 12345),
            ]
        )
        
        return DataResult.success(mockDao)
    }
}
