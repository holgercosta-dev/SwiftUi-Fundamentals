//
//  HomScreenDependencies.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import SwiftUI

extension View {
    func injectHomeScreenDependencies() -> some View {
        self.modifier(HomeScreenProvider())
    }

    func injectMockHomeScreenDependencies() -> some View {
        self.modifier(MockHomeScreenProvider())
    }
}

private struct HomeScreenProvider: ViewModifier {

    @State var viewModel = HomeVM()
    var useCase = GetHealthData()
    var mapper = HomeUiMapper()

    func body(content: Content) -> some View {
        content
            .environment(useCase)
            .environment(mapper)
            .environment(viewModel)
    }
}

//Todo: configure mock provider
private struct MockHomeScreenProvider: ViewModifier {

    @State var viewModel = HomeVM(
        getHealthData: GetHealthData(
            healthDataRepository: DefaultHealthDataRepository(
                healthKitController: MockHealthKitController()
            )
        )
    )

    func body(content: Content) -> some View {
        viewModel.uiState = UiState.success(
            HomeUiState(
                calories: 123,
                active: 123,
                stand: 123,
                caloriesLabel: "123",
                activeLabel: "123",
                standLabel: "123"
            )
        )

        return
            content
            .environment(viewModel)
        //            .environment(useCase)
        //.environment(mapper)

    }

}
