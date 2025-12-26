//
//  Date.swift
//  FitnessApp
//
//  Created by Roger Knowws on 26/12/2025.
//

import Foundation

extension Date {
    func formatWorkoutDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
}
