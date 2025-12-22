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
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(homeVM.calories) kcal")
                                    .bold()
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(homeVM.active) mins")
                                    .bold()
                            }
                            .padding(.top)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(homeVM.stand) hours")
                                    .bold()
                            }
                            .padding(.top)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(
                                progress: $homeVM.calories,
                                goal: 600,
                                color: .red
                            )
                            
                            ProgressCircleView(
                                progress: $homeVM.active,
                                goal: 600,
                                color: .green
                            )
                            .padding(.all, 20)
                            
                            ProgressCircleView(
                                progress: $homeVM.stand,
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
                        ActivityCard(activity: Activity.sample)
                        ActivityCard(activity: Activity.sample)
                        ActivityCard(activity: Activity.sample)
                        ActivityCard(activity: Activity.sample)
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
        .task {
            await homeVM.loadHealthData()
        }
    }
}

#Preview {
    let vm = HomeVM()
    HomeScreen()
        .environment(vm)
}
