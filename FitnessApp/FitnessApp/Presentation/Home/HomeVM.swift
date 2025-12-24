//
//  HomeVM.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Observation
import SwiftUI

@Observable
class HomeUiState {

    init(
        calories: Int,
        active: Int,
        stand: Int,
        caloriesLabel: String,
        activeLabel: String,
        standLabel: String
    ) {
        self.calories = calories
        self.active = active
        self.stand = stand
        self.caloriesLabel = caloriesLabel
        self.activeLabel = activeLabel
        self.standLabel = standLabel
    }

    var calories: Int = 0
    var active: Int = 0
    var stand: Int = 0
    var caloriesLabel: String = ""
    var activeLabel: String = ""
    var standLabel: String = ""
}

class HomeVM: ObservableVM {

    @Environment(GetHealthData.self) var getHealthData: GetHealthData

    var uiState: UiState<HomeUiState> = UiState.idle

    func loadHealthData() async {
        let result = await getHealthData.execute(
            type: HealthDataType.today.rawValue
        )

        switch result {
        case .success(let healthKit):
            print(healthKit)
            self.uiState = UiState.success(
                HomeUiState(
                    calories: 0,
                    active: 0,
                    stand: 0,
                    caloriesLabel: "healthKit.calories",
                    activeLabel: "healthKit.active",
                    standLabel: "healthKit.stand"
                )
            )
        case .failure(let error):
            self.uiState = UiState.error(error)
        }
    }

}
