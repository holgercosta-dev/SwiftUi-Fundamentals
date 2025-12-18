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
    var url: URL
    @Binding
    var isShowingDetail: Bool
    @State
    private var isShowingSafari = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingDetail = false
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
                isShowingSafari = true
            } label: {
                AFButton(title: "Learn More")
            }
        }
        .sheet(
            isPresented: $isShowingSafari,
            onDismiss: { isShowingSafari = false }
        ) {
            SafariView(url: url)
        }
    }
}

#Preview {
    let framework = MockData.sampleFramework
    FrameworkDetailView(
        name: framework.name,
        imageName: framework.imageName,
        description: framework.description,
        url: URL(string: "https://google.com")!,
        isShowingDetail: .constant(false),
    )
}
