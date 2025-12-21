//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Roger Knowws on 21/12/2025.
//

import SwiftUI

struct FitnessTabView: View {
    
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tag("Home")
                .tabItem { Image(systemName: "house") }
            
            HistoricDataScreen()
                .tag("Historic_Data")
                .tabItem { Image(systemName: "chart.line.uptrend.xyaxis") }
        }
    }
}

#Preview {
    FitnessTabView()
}
