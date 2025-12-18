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
            List {
                ForEach(MockData.frameworks) { framework in
                    NavigationLink(
                        destination: FrameworkDetailView(
                            name: framework.name,
                            imageName: framework.imageName,
                            description: framework.description,
                            url: URL(string: framework.urlString)!,
                            isShowingDetail: $viewModel.isShowingDetail
                        ),
                        label: {
                            FrameworkTitleView(
                                name: framework.name,
                                imageName: framework.imageName
                            )
                        }
                    )
                }
            }
            .navigationTitle("Frameworks")
        }
        .accentColor(Color(.label))
    }
}

#Preview {
    FrameworkGridView()
}
