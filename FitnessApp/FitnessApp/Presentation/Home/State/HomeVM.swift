//
//  HomeVM.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Observation
import SwiftUI

class HomeVM: ObservableVM {

    //@Environment(GetHealthData.self) var getHealthData: GetHealthData
    private var getHealthData: GetHealthData = GetHealthData()
    //@Environment(HomeUiMapper.self) private var mapper: HomeUiMapper
    private let mapper: HomeUiMapper = HomeUiMapper()
    
    required init() {
        
    }
    
    required init(getHealthData: GetHealthData) {
        self.getHealthData = getHealthData
    }

    var uiState: UiState<HomeUiState> = UiState.idle

    func loadHealthData() async {
        let result = await getHealthData.execute(
            type: HealthDataType.today.rawValue
        )

        switch result {
        case .success(let healthKit):
            let mappedState = mapper.mapFrom(data: healthKit)
            print(mappedState.activities)
            print(mappedState.workouts)
            self.uiState = UiState.success(mappedState)
        case .failure(let error):
            self.uiState = UiState.error(error)
        }
    }

}
