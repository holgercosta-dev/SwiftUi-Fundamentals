//
//  MockHealthKitController.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

struct MockHealthKitController: HealthKitControllerProtocol {
    func fetch(type: HealthDataType) async -> DataResult<HealthKitDao, any Error> {
        let mockDao = HealthKitDao(calories: 111, exercise: 222, stand: 123)
        return DataResult.success(mockDao)
    }
}
