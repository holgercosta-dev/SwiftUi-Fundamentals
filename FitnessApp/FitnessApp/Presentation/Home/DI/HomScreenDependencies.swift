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

    func body(content: Content) -> some View {
        content
        //            .environment(useCase)
        //            .environment(mapper)
        //            .environment(viewModel)
    }

}
