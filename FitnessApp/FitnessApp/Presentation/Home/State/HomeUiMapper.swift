//
//  HomeUiMapper.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import SwiftUI

@Observable
class HomeUiMapper {
    func mapFrom(data: HealthKit) -> HomeUiState {
        let finalCalories = Int(data.calories ?? 0)
        let finalExercise = Int(data.exercise ?? 0)
        let finalStand = Int(data.stand ?? 0)

        return HomeUiState(
            calories: finalCalories,
            active: finalExercise,
            stand: finalStand,
            caloriesLabel: "\(finalCalories) kcal",
            activeLabel: "\(finalExercise) minutes",
            standLabel: "\(finalStand) hours",
            activities: [
                mapStepsActivity(with: data.steps),
                mapRunningActivity(
                    with: data.exerciseDurationsForCurrentWeek[
                        Exercise.running.rawValue
                    ]
                ),
                mapStrengthActivity(
                    with: data.exerciseDurationsForCurrentWeek[
                        Exercise.strength.rawValue
                    ]
                ),
                mapSoccerActivity(
                    with: data.exerciseDurationsForCurrentWeek[
                        Exercise.soccer.rawValue
                    ]
                ),
                mapStairStepperActivity(
                    with: data.exerciseDurationsForCurrentWeek[
                        Exercise.stairs.rawValue
                    ]
                ),
                mapBasketballActivity(
                    with: data.exerciseDurationsForCurrentWeek[
                        Exercise.basketball.rawValue
                    ]
                ),
                mapKickboxingActivity(
                    with: data.exerciseDurationsForCurrentWeek[
                        Exercise.kickboxing.rawValue
                    ]
                ),
            ]
            .compactMap { $0 },
            workouts: data.workoutData.prefix(4).compactMap { workoutData in
                Workout(
                    title: "Title",
                    image: "Image",
                    tintColor: .blue,
                    duration: "\(workoutData.duration)",
                    date: workoutData.startDate.formatWorkoutDate(),
                    calories: "\(workoutData.energyBurned)"
                )
            }
        )
    }

    private func mapStepsActivity(with steps: Double?) -> Activity? {
        return steps.map {
            Activity(
                title: "Steps Today",
                subtitle: "Goal: 000000",
                image: "figure.walk",
                tintColor: .green,
                amount: "\(Int($0))"
            )
        }
    }

    private func mapRunningActivity(with running: Int?) -> Activity? {
        return running.map {
            Activity(
                title: "Running",
                subtitle: "This week",
                image: "figure.run",
                tintColor: .green,
                amount: "\($0)"
            )
        }
    }

    private func mapStrengthActivity(with strength: Int?) -> Activity? {
        return strength.map {
            Activity(
                title: "Strength Training",
                subtitle: "This week",
                image: "dumbell",
                tintColor: .blue,
                amount: "\($0)"
            )
        }
    }

    private func mapSoccerActivity(with soccer: Int?) -> Activity? {
        return soccer.map {
            Activity(
                title: "Soccer",
                subtitle: "This week",
                image: "figure.soccer",
                tintColor: .cyan,
                amount: "\($0)"
            )
        }
    }

    private func mapBasketballActivity(with basketball: Int?) -> Activity? {
        return basketball.map {
            Activity(
                title: "BasketBall",
                subtitle: "This week",
                image: "figure.basketball",
                tintColor: .indigo,
                amount: "\($0)"
            )
        }
    }

    private func mapStairStepperActivity(with stairs: Int?) -> Activity? {
        return stairs.map {
            Activity(
                title: "Stairs",
                subtitle: "This week",
                image: "figure.stairs",
                tintColor: .green,
                amount: "\($0)"
            )
        }
    }

    private func mapKickboxingActivity(with kickboxing: Int?) -> Activity? {
        return kickboxing.map {
            Activity(
                title: "Kickboxing",
                subtitle: "This week",
                image: "figure.kickboxing",
                tintColor: .blue,
                amount: "\($0)"
            )
        }
    }
}
