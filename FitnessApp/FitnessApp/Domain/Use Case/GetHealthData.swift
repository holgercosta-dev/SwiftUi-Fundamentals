//
//  GetHealthData.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Foundation
import Observation

@Observable
class GetHealthData {

    private let healthDataRepository: HealthDataRepositoryProtocol

    init(
        healthDataRepository: HealthDataRepositoryProtocol =
            DefaultHealthDataRepository()
    ) {
        self.healthDataRepository = healthDataRepository
    }

    func execute(type HealthDataTypeString: String) async {
        await healthDataRepository.getDataFor(type: HealthDataTypeString)
    }
}
