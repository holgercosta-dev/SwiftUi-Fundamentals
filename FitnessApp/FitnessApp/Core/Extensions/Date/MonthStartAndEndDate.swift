//
//  MonthStartAndEndDate.swift
//  FitnessApp
//
//  Created by Roger Knowws on 25/12/2025.
//

import Foundation

extension Date {
    nonisolated func monthStartAndEndDate() -> (Date, Date) {
        let calendar = Calendar.current
        let startDateComponent = calendar.dateComponents(
            [.year, .month],
            from: calendar.startOfDay(for: self)
        )
        let startDate = calendar.date(from: startDateComponent) ?? self
        let endDate = calendar.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: startDate
        ) ?? self

        return (startDate, endDate)
    }
}
