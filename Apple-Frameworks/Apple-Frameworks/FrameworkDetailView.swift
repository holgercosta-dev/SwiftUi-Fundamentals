//
//  FrameworkDetailView.swift
//  Apple-Frameworks
//
//  Created by Roger Knowws on 18/12/2025.
//

import SwiftUI

struct FrameworkDetailView: View {
    var name: String
    var imageName: String
    var description: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.label))
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                }
                .padding()
            }
            Spacer()
            FrameworkTitleView(name: name, imageName: imageName)
            Text(description)
                .font(.body)
                .padding()
            Spacer()
            Button {
                
            } label: {
                AFButton(title: "Learn More")
            }
        }
    }
}

#Preview {
    let framework = MockData.sampleFramework
    FrameworkDetailView(
        name: framework.name,
        imageName: framework.imageName,
        description: framework.description
    )
}
