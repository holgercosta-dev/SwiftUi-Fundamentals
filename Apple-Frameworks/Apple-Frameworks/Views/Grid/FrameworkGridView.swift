//
//  FrameworkGridView.swift
//  Apple-Frameworks
//
//  Created by Roger Knowws on 18/12/2025.
//

import SwiftUI

struct FrameworkGridView: View {
    @StateObject
    var viewModel = FrameworkGridVM()


    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(MockData.frameworks) { framework in
                        FrameworkTitleView(
                            name: framework.name,
                            imageName: framework.imageName
                        )
                        .onTapGesture {
                            viewModel.selectedFramework = framework
                        }
                    }
                }
            }
            .navigationTitle("Frameworks")
            .sheet(
                isPresented: $viewModel.isShowingDetail,
                onDismiss: { viewModel.isShowingDetail = false },
                content: {
                    let framework =
                        viewModel.selectedFramework ?? MockData.sampleFramework
                    FrameworkDetailView(
                        name: framework.name,
                        imageName: framework.imageName,
                        description: framework.description,
                        url: URL(string: framework.urlString) ?? URL(
                            string: "https://google.com"
                        )!,
                        isShowingDetail: $viewModel.isShowingDetail,
                    )
                }
            )
        }
    }
}

#Preview {
    FrameworkGridView()
}
