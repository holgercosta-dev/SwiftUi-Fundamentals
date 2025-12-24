//
//  DefaultHealthDataRepository.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Foundation

actor DefaultHealthDataRepository: HealthDataRepositoryProtocol {

    private let healthKitController: HealthKitControllerProtocol

    init(healthKitController: HealthKitControllerProtocol = DefaultHealthKitController()) {
        self.healthKitController = healthKitController
    }

    func getHealthKitDataFor(type HealthDataTypeString: String) async -> DataResult<HealthKitDao, Error> {
        let type =
            HealthDataType(rawValue: HealthDataTypeString)
            ?? HealthDataType.unknown

        return await healthKitController.fetch(type: type)
    }

}
