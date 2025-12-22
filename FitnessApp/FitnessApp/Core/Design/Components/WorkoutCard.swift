//
//  WorkoutCard.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import SwiftUI

struct Workout {
    let id: Int
    let title: String
    let image: String
    let tintColor: Color
    let duration: String
    let date: String
    let calories: String

    static var sample = Workout(
        id: 0,
        title: "Running",
        image: "figure.run",
        tintColor: .cyan,
        duration: "51 mins",
        date: "Aug 1",
        calories: "512 kcal"
    )
}

struct WorkoutCard: View {

    @State var workout: Workout

    var body: some View {
        HStack {
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(workout.tintColor)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)

            VStack(spacing: 16) {
                HStack {
                    Text(workout.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.title3)
                        .bold()

                    Spacer()

                    Text(workout.duration)
                }

                HStack {
                    Text(workout.date)

                    Spacer()

                    Text(workout.calories)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutCard(workout: Workout.sample)
    Spacer()
}
