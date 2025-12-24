//
//  StartOfDay.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Foundation

extension Date {
    
    nonisolated
    static var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
    
}
