//
//  HomeVM.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//


import SwiftUI
import Observation

class HomeVM: ObservableVM {
    
    @Environment(GetHealthData.self) var getHealthData: GetHealthData
    
    var calories: Int = 123
    var active: Int = 123
    var stand: Int = 123
    
    
    func loadHealthData() async {
        await getHealthData.execute(type: "calories")
    }
}
