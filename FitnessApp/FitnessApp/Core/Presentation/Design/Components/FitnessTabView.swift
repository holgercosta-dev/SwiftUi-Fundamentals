//
//  FitnessTabView.swift
//  FitnessApp
//
//  Created by Roger Knowws on 21/12/2025.
//

import SwiftUI

struct FitnessTabView: View {

    @State var selectedTab = "Home"

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .green
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.green,
        ]

        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .injectHomeScreenDependencies()
                

            HistoricDataScreen()
                .tag("Historic_Data")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("History")
                }
        }
    }
}

#Preview {
    FitnessTabView()
}
