//
//  HealthKitDao.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

nonisolated
struct HealthKitDao {
    var calories: Double?
    var exercise: Double?
    var stand: Double?
}

extension HealthKitDao {
    
    func toDomain() -> HealthKit {
        return HealthKit()
    }
    
}
