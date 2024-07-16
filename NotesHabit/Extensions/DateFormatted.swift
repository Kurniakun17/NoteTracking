//
//  DateFormatted.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/07/24.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        let calendar = Calendar.current

        if calendar.isDateInToday(self) {
            formatter.dateFormat = "HH.mm"
        } else if calendar.isDateInYesterday(self) {
            formatter.dateFormat = "'Yesterday,' HH:mm"
        } else {
            formatter.dateFormat = "dd/MM/yyyy"
        }

        return formatter.string(from: self)
    }
}

extension Date {
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
