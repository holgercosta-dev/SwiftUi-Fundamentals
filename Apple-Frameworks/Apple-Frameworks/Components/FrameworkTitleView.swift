//
//  FrameworkTitleView.swift
//  Apple-Frameworks
//
//  Created by Roger Knowws on 18/12/2025.
//


import SwiftUI

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

#Preview {
    FrameworkTitleView(name: "Name", imageName: "app-clip")
}
