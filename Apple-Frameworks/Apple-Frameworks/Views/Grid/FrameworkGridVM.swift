//
//  FrameworkGridVM.swift
//  Apple-Frameworks
//
//  Created by Roger Knowws on 18/12/2025.
//

import SwiftUI
import Combine

class FrameworkGridVM: ObservableObject {
    
    let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
    ]
    
    var selectedFramework: Framework? {
        didSet {
            isShowingDetail = true
        }
    }
    @Published
    var isShowingDetail: Bool = false
}
