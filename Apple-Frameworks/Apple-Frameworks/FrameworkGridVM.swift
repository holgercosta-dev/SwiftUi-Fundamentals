//
//  FrameworkGridVM.swift
//  Apple-Frameworks
//
//  Created by Roger Knowws on 18/12/2025.
//

import Combine

class FrameworkGridVM: ObservableObject {
    
    var selectedFramework: Framework? {
        didSet {
            isShowingDetail = true
        }
    }
    @Published
    var isShowingDetail: Bool = false
}
