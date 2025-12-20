//
//  SearchScreen.swift
//  GhibliApp
//
//  Created by Roger Knowws on 20/12/2025.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Show search here")
                .searchable(text: $text)
        }
    }
}

#Preview {
    SearchScreen()
}
