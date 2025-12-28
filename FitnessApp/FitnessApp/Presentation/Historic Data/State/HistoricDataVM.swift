//
//  HistoricDataVM.swift
//  FitnessApp
//
//  Created by Roger Knowws on 26/12/2025.
//

import Foundation

@Observable
class HistoricDataUiState {
    let stepsChartData: [StepsData] = []
    
}

struct StepsData: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let count: Int
}

class HistoricDataVM: ObservableVM {
    
    enum ChartOptions: String, CaseIterable {
        case oneWeek = "1W"
        case oneMonth = "1M"
        case threeMonth = "3M"
        case yearToDate = "YTD"
        case oneYear = "1Y"
    }
    
    var uiState: UiState<HistoricDataUiState> = .idle
    
    var selectedChart: ChartOptions = .oneWeek
    
}
