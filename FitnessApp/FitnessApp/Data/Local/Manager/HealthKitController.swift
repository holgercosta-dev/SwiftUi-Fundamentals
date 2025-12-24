//
//  HealthManager.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Combine
import Foundation
import HealthKit

enum HealthDataType: String {
    case today = "today"
    case unknown = "unknown"
}

actor HealthKitController {

    private let healthStore: HKHealthStore

    init(healthstore: HKHealthStore = HKHealthStore()) {
        self.healthStore = healthstore
        Task {
            await loadHealthData()
        }
    }

    private func loadHealthData() async {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)

        let healthTypes: Set = [calories, exercise, stand]

        do {
            try await healthStore.requestAuthorization(
                toShare: [],
                read: healthTypes,
            )
        } catch {
            print(error)
        }
    }

    func fetch(type: HealthDataType)
    async -> DataResult<HealthKitDao, Error> {

        switch type {
        case .today:
            do {
                let data = try await fetchHealthDataForToday()
                return DataResult.success(data)
            } catch {
                return DataResult.failure(error)
            }
        case .unknown:
            return DataResult.failure(NSError())
        }

    }
}

extension HealthKitController {
    private func fetchHealthDataForToday() async throws -> HealthKitDao {
        
        var healthKitDao = HealthKitDao()
        var localError: Error? = nil
        
        fetchCaloriesBurnedForToday { result in
            do {
                healthKitDao.calories = try result.get()
            } catch {
                print(error.localizedDescription)
                localError = error
            }
        }
        
        fetchExerciseForToday { result in
            do {
                healthKitDao.exercise = try result.get()
            } catch {
                print(error.localizedDescription)
                localError = error
            }
        }
        
        fetchStandingHoursForToday { result in
            do {
                healthKitDao.stand = try result.get()
            } catch {
                print(error.localizedDescription)
                localError = error
            }
        }
        
        guard localError == nil else {
            //Todo: validate data before throwing error? Or see what kind of error before throwing it? Could we show partial data?
            throw localError!
        }
        
        return healthKitDao
        
    }

    //Todo: refactor duplicate code
    private func fetchCaloriesBurnedForToday(
        completion: @escaping ((Result<Double, Error>) -> Void)
    ) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(
            withStart: .startOfDay,
            end: Date()
        )

        let query = HKStatisticsQuery(
            quantityType: calories,
            quantitySamplePredicate: predicate
        ) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }

            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }

        healthStore.execute(query)
    }

    private func fetchExerciseForToday(
        completion: @escaping ((Result<Double, Error>) -> Void)
    ) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(
            withStart: .startOfDay,
            end: Date()
        )

        let query = HKStatisticsQuery(
            quantityType: exercise,
            quantitySamplePredicate: predicate
        ) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }

            let exerciseTime = quantity.doubleValue(for: .kilocalorie())
            completion(.success(exerciseTime))
        }

        healthStore.execute(query)
    }

    private func fetchStandingHoursForToday(
        completion: @escaping ((Result<Double, Error>) -> Void)
    ) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(
            withStart: .startOfDay,
            end: Date()
        )

        let query = HKSampleQuery(
            sampleType: stand,
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: nil,
        ) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil
            else {
                completion(.failure(NSError()))
                return
            }

            let standCount = samples.filter { $0.value == 0 }.count
            completion(.success(Double(standCount)))
        }

        healthStore.execute(query)
    }
}
