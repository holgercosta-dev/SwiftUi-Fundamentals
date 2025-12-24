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

    func execute(type HealthDataTypeString: String) async -> DomainResult<HealthKit, Error> {
        
        let dataResult =  await healthDataRepository.getHealthKitDataFor(
            type: HealthDataTypeString
        )
        
        switch dataResult {
        case .success(let healthKitData):
            return DomainResult.success(healthKitData.toDomain())
        case .failure(let error):
            return DomainResult.failure(error)
        }
    }
}
