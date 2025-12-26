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

actor DefaultHealthKitController {

    private let healthStore: HKHealthStore

    init(healthstore: HKHealthStore = HKHealthStore()) {
        self.healthStore = healthstore
    }
}

extension DefaultHealthKitController: HealthKitControllerProtocol {
    func fetch(type: HealthDataType)
        async -> DataResult<HealthKitDao, Error>
    {
        if await checkIfAuthIsNeeded() {
            await showAuth()
        }

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

extension DefaultHealthKitController {

    private func checkIfAuthIsNeeded() async -> Bool {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)

        let healthTypes: Set = [calories, exercise, stand, steps]

        do {
            let status = try await healthStore.statusForAuthorizationRequest(
                toShare: [],
                read: healthTypes
            )

            return status != HKAuthorizationRequestStatus.unnecessary
        } catch {
            print(error)
            return true
        }
    }

    private func showAuth() async {
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

        fetchStepsForToday { result in
            do {
                healthKitDao.steps = try result.get()
            } catch {
                print(error.localizedDescription)
                localError = error
            }
        }

        fetchCurrentWeekWorkoutStats { result in
            do {
                healthKitDao.exerciseDurationsForCurrentWeek = try result.get()
            } catch {
                print(error.localizedDescription)
                localError = error
            }
        }
        
        fetchWorkoutsForMonth(month: Date()) { result in
            do {
                healthKitDao.workoutData = try result.get()
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

    private func fetchStepsForToday(
        completion: @escaping ((Result<Double, Error>) -> Void)
    ) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(
            withStart: .startOfDay,
            end: Date()
        )

        let query = HKStatisticsQuery(
            quantityType: steps,
            quantitySamplePredicate: predicate
        ) { _, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }

            let steps = quantity.doubleValue(for: .count())
            completion(.success(steps))
        }

        healthStore.execute(query)
    }

    private func fetchCurrentWeekWorkoutStats(
        completion: @escaping ((Result<[Exercise: Int], Error>) -> Void)
    ) {
        let workouts = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(
            withStart: .startOfWeek,
            end: Date()
        )
        let query = HKSampleQuery(
            sampleType: workouts,
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: nil
        ) { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(NSError()))
                return
            }

            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var basketballCount: Int = 0
            var stairsCount: Int = 0
            var kickboxingcount: Int = 0

            for workout in workouts {
                let duration = Int(workout.duration) / 60
                if workout.workoutActivityType == .running {
                    runningCount += duration
                } else if workout.workoutActivityType
                    == .traditionalStrengthTraining
                {
                    strengthCount += duration
                } else if workout.workoutActivityType == .soccer {
                    soccerCount += duration
                } else if workout.workoutActivityType == .basketball {
                    basketballCount += duration
                } else if workout.workoutActivityType == .stairs {
                    stairsCount += duration
                } else if workout.workoutActivityType == .kickboxing {
                    kickboxingcount += duration
                }
            }

            let map = [
                Exercise.running: runningCount,
                Exercise.strength: strengthCount,
                Exercise.soccer: soccerCount,
                Exercise.basketball: basketballCount,
                Exercise.stairs: stairsCount,
                Exercise.kickboxing: kickboxingcount,
            ]

            completion(.success(map))
        }

        healthStore.execute(query)
    }

    private func fetchWorkoutsForMonth(
        month: Date,
        completion: @escaping (Result<[WorkoutDataDao], Error>) -> Void
    ) {
        let workouts = HKSampleType.workoutType()
        let (startDate, endDate) = month.monthStartAndEndDate()
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate
        )
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
            ascending: false
        )
        let query = HKSampleQuery(
            sampleType: workouts,
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [sortDescriptor]
        ) { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(NSError()))
                return
            }

            let workoutsArray = workouts.map {
                WorkoutDataDao(
                    type: $0.workoutActivityType.rawValue,
                    duration: $0.duration,
                    startDate: $0.startDate,
                    energyBurned: $0.totalEnergyBurned?.doubleValue(
                        for: .kilocalorie()
                    ) ?? 0
                )
            }

            completion(.success(workoutsArray))
        }
        
        healthStore.execute(query)
    }
}
