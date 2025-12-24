//
//  HomeVM.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Observation
import SwiftUI

class HomeVM: ObservableVM {

    @Environment(GetHealthData.self) var getHealthData: GetHealthData
    @Environment(HomeUiMapper.self) var mapper: HomeUiMapper

    var uiState: UiState<HomeUiState> = UiState.idle

    func loadHealthData() async {
        let result = await getHealthData.execute(
            type: HealthDataType.today.rawValue
        )

        switch result {
        case .success(let healthKit):
            print(healthKit)
            let mappedState = mapper.mapFrom(data: healthKit)
            self.uiState = UiState.success(mappedState)
        case .failure(let error):
            self.uiState = UiState.error(error)
        }
    }

}
