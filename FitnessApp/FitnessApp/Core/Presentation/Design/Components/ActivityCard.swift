//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let tintColor: Color
    let amount: String

    static var sample = Activity(
        id: 0,
        title: "Today Steps",
        subtitle: "Goal 12,000",
        image: "figure.walk",
        tintColor: .green,
        amount: "9812"
    )
}

struct ActivityCard: View {

    @State var activity: Activity

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(activity.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .bold()
                    Text(activity.subtitle)
                        .font(.caption)
                }

                Spacer()

                Image(systemName: activity.image)
                    .foregroundColor(activity.tintColor)
            }

            Text(activity.amount)
                .font(.title)
                .bold()
                .padding()

        }
        .padding()
        .background(.gray.opacity(0.1))
        .cornerRadius(10)        
    }
}

#Preview {
    ActivityCard(activity: Activity.sample)
    Spacer()
}
