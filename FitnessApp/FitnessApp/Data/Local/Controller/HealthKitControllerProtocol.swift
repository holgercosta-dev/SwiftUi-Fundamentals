//
//  HealthKitControllerProtocol.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

protocol HealthKitControllerProtocol: Sendable {
    func fetch(type: HealthDataType)async -> DataResult<HealthKitDao, Error>
}
