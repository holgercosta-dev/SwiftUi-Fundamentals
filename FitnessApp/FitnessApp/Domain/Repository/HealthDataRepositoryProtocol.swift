//
//  HealthDataRepositoryProtocol.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Foundation

protocol HealthDataRepositoryProtocol {
    func getHealthKitDataFor(type HealthDataTypeString: String) async -> DataResult<HealthKitDao, Error>
}
