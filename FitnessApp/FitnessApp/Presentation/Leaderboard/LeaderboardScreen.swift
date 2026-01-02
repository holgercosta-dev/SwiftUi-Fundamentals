//
//  LeaderboardScreen.swift
//  FitnessApp
//
//  Created by Roger Knowws on 02/01/2026.
//

import SwiftUI

struct LeaderboardUser: Codable, Identifiable {
    var id: UUID = UUID()
    let createdAt: String
    let username: String
    let count: Int

    static var sampleData = [
        LeaderboardUser(createdAt: "", username: "name", count: 1234),
        LeaderboardUser(createdAt: "", username: "name", count: 1234),
        LeaderboardUser(createdAt: "", username: "name", count: 1234),
        LeaderboardUser(createdAt: "", username: "name", count: 1234),
        LeaderboardUser(createdAt: "", username: "name", count: 1234),
        LeaderboardUser(createdAt: "", username: "name", count: 1234),
    ]
}

struct LeaderboardScreen: View {
    
    @AppStorage("username") var username: String?
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()

            HStack {
                Text("Name")
                    .bold()

                Spacer()

                Text("Steps")
                    .bold()
            }
            .padding()

            LazyVStack(spacing: 12) {
                ForEach(
                    Array(LeaderboardUser.sampleData.enumerated()),
                    id: \.offset
                ) { index, user in
                    HStack {
                        Text("\(index + 1).")

                        Text(user.username)

                        Spacer()

                        Text("\(user.count)")
                    }
                    .padding(.horizontal)
                }
            }
        }

        Spacer()
    }
}

#Preview {
    LeaderboardScreen()
}
