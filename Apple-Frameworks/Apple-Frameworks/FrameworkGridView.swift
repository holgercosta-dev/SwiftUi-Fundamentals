//
//  FrameworkGridView.swift
//  Apple-Frameworks
//
//  Created by Roger Knowws on 18/12/2025.
//

import SwiftUI

struct FrameworkGridView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(MockData.frameworks) { framework in
                        FrameworkTitleView(
                            name: framework.name,
                            imageName: framework.imageName
                        )
                    }
                }
            }
            .navigationTitle("Frameworks")
        }
    }
}

#Preview {
    FrameworkGridView()
}

struct FrameworkTitleView: View {
    var name: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
    }
}
