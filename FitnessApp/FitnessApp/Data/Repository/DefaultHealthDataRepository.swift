//
//  DefaultHealthDataRepository.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Foundation

class DefaultHealthDataRepository: HealthDataRepositoryProtocol {

    private let healthManager: HealthKitController

    init(healthManager: HealthKitController = HealthKitController()) {
        self.healthManager = healthManager
    }

    func getDataFor(type HealthDataTypeString: String) async {
        let type =
            HealthDataType(rawValue: HealthDataTypeString)
            ?? HealthDataType.active
        
        await healthManager.fetch(type: type)
    }

}
