//
//  HomeScreen.swift
//  FitnessApp
//
//  Created by Roger Knowws on 21/12/2025.
//

import SwiftUI
import Observation

struct HomeScreen: View {
    
    @Environment(HomeVM.self) var homeVM: HomeVM

    var body: some View {
        @Bindable var homeVM = homeVM
        
        Group {
            switch homeVM.uiState {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success(let state):
                SuccessContent(state)
            case .error(let error):
                ErrorContent(error)
            }
        }
        .task {
            await homeVM.loadHealthData()
        }
        
    }
}

extension HomeScreen {
    private func SuccessContent(_ state: HomeUiState) -> some View {
        NavigationStack {
            @Bindable var state = state
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text(state.caloriesLabel)
                                    .bold()
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text(state.activeLabel)
                                    .bold()
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text(state.standLabel)
                                    .bold()
                            }
                            .padding(.top)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(
                                progress: $state.calories,
                                goal: 600,
                                color: .red
                            )
                            
                            ProgressCircleView(
                                progress: $state.active,
                                goal: 600,
                                color: .green
                            )
                            .padding(.all, 20)
                            
                            ProgressCircleView(
                                progress: $state.stand,
                                goal: 600,
                                color: .blue
                            )
                            .padding(.all, 40)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(
                        columns: Array(repeating: GridItem(spacing: 20), count: 2)
                    ) {
                        ForEach(state.activities) {
                            ActivityCard(activity: $0)
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    LazyVStack {
                        WorkoutCard(workout: Workout.sample)
                        WorkoutCard(workout: Workout.sample)
                        WorkoutCard(workout: Workout.sample)
                        WorkoutCard(workout: Workout.sample)
                    }
                }
            }
        }
    }
    
    private func ErrorContent(_ error: Error) -> some View {
        Text("Something went wrong.\n \(error.localizedDescription)")
    }
}

#Preview {
    HomeScreen()
        .injectMockHomeScreenDependencies()
}
