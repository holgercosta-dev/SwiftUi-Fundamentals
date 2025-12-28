//
//  HistoricDataScreen.swift
//  FitnessApp
//
//  Created by Roger Knowws on 21/12/2025.
//

import Charts
import SwiftUI

struct HistoricDataScreen: View {

    //@Environment(HistoricDataVM.self) private var historicDataVM: HistoricDataVM
    
    @State private var historicDataVM = HistoricDataVM()

    var body: some View {
        @Bindable var vm = historicDataVM
        
        VStack {
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            Chart {
                let array = [
                    Workout.sample,
                    Workout.sample,
                    Workout.sample,
                    Workout.sample,
                    Workout.sample,
                ]
                ForEach(array) { data in
                    BarMark(
                        x: .value(Date().formatted(), Date(), unit: .day),
                        y: .value("Steps", "count")
                    )
                }
            }
            .foregroundColor(.green)
            .frame(maxHeight: 350)
            .padding()

            HStack {
                ForEach(HistoricDataVM.ChartOptions.allCases, id: \.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation {
                            vm.selectedChart = option
                        }
                    }
                    .padding()
                    .foregroundColor(
                        vm.selectedChart == option ? .white : .green
                    )
                    .background(
                        vm.selectedChart == option ? .green : .white
                    )
                    .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    HistoricDataScreen()
        .injectVM(HistoricDataVM.self)
}
