//
//  Injectable.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import SwiftUI

//Does not work well with updating observable state because it seems to create
//an extra layer that "disconnects" the bindable properties.
@Observable
class ObservableVM {
    
    required init() {
        
    }
    
}

extension View {
    func injectVM<T: ObservableVM>(_ type: T.Type) -> some View {
        @State var vm = T()
        return environment(vm)
    }
}
