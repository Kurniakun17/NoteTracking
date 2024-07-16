//
//  HelperFunction.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//

import Foundation
import UserNotifications

func isInLast7Days(_ date: Date) -> Bool {
    guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
        return false
    }
    return date >= sevenDaysAgo && date < Date()
}

func isInLast30Days(_ date: Date) -> Bool {
    guard let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date()) else {
        return false
    }
    return date >= thirtyDaysAgo && date < Date()
}

func groupNotesByMonth(notes: [NoteModel]) -> [GroupedNotes] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"

    let grouped = Dictionary(grouping: notes) { note in
        dateFormatter.string(from: note.createdAt)
    }

    return grouped.map { GroupedNotes(month: $0.key, notes: $0.value) }.sorted { $0.month > $1.month }
}

func scheduleNotifications(for days: Set<Int>, at time: Date) {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: time)
    let minute = calendar.component(.minute, from: time)
    
    for day in days {
        var dateComponents = DateComponents()
        dateComponents.weekday = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.subtitle = "It's time to work on your habit!"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}

