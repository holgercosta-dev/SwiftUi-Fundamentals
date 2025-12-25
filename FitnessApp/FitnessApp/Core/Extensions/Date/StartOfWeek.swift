//
//  StartOfWeek.swift
//  FitnessApp
//
//  Created by Roger Knowws on 25/12/2025.
//

import Foundation

extension Date {
    nonisolated static var startOfWeek: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2
        
        return calendar.date(from: components) ?? Date()
    }
}
