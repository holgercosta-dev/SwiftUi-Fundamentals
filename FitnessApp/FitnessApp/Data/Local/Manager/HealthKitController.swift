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
    case calories = "calories"
    case active = "active"
    case stand = "stand"
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

    //Todo: create generic function to fetch data as a double by passing an enum value that represents the data we want
    func fetch(type: HealthDataType) async -> Double? {
        var calorieCount: Double?
        fetchCaloriesBurnedForToday { result in
            do {
                calorieCount = try result.get()
            } catch {
                calorieCount = nil
            }
        }

        return calorieCount
    }

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
