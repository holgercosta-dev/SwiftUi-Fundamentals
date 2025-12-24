//
//  HomScreenDependencies.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import SwiftUI

extension View {
    func injectHomeScreenDependencies(useMocks: Bool = false) -> some View {
        self.modifier(HomeScreenProvider(useMocks: useMocks))
    }
}

struct HomeScreenProvider: ViewModifier {
    
    let useMocks: Bool
    
    @State var viewModel = HomeVM()
    @State var useCase = GetHealthData()

    func body(content: Content) -> some View {
        content
            .environment(useCase)
            .environment(viewModel)
    }
}
