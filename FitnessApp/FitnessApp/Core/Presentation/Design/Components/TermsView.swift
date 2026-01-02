//
//  TermsView.swift
//  FitnessApp
//
//  Created by Roger Knowws on 02/01/2026.
//

import SwiftUI

struct TermsView: View {
    
    @State var name = ""
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            
            TextField("Username", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                )
                .padding(.horizontal)
        }
    }
}

#Preview {
    TermsView()
}
