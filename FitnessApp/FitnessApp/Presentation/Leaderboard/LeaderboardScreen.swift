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
            
            LazyVStack {
                ForEach(LeaderboardUser.sampleData) { user in
                    HStack {
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
