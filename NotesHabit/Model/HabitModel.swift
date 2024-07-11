//
//  GoalModel.swift
//  NoteTrack
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import Foundation
import SwiftData

@Model
class HabitModel: Identifiable {
    var id = UUID()
    var title: String
    var body: String
    var days: Set<Int>
    var startDate = Date()
    var folder: FolderModel?
    var emoji: String

    @Relationship(deleteRule: .cascade, inverse: \NoteModel.goal)
    var notes: [NoteModel] = []

    @Relationship(deleteRule: .cascade, inverse: \ReminderModel.goal)
    var reminders: [ReminderModel] = []
    var isReminder = false
    var createAt = Date()
    var updateAt = Date()
    var deleteAt: Date?
    var streak: Int

    var lastLog: Date?

    init(id: UUID = UUID(), title: String, body: String, days: Set<Int>, startDate: Date = Date(), folder: FolderModel? = nil, emoji: String, notes: [NoteModel], reminders: [ReminderModel], isReminder: Bool = false, createAt: Date = Date(), updateAt: Date = Date(), deleteAt: Date? = nil, streak: Int, lastLog: Date? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.days = days
        self.startDate = startDate
        self.folder = folder
        self.emoji = emoji
        self.notes = notes
        self.reminders = reminders
        self.isReminder = isReminder
        self.createAt = createAt
        self.updateAt = updateAt
        self.deleteAt = deleteAt
        self.streak = streak
        self.lastLog = lastLog
    }
}


//struct MockData {
//    static let habit1 = HabitModel(
//        title: "Morning Exercise",
//        body: "Do a 30-minute workout",
//        days: [1, 3, 5],
//        folder: nil,
//        emoji: "💪",
//        notes: [
//            NoteModel(title: "Start with warm-up", body: "5-minute warm-up", date: Date()),
//            NoteModel(title: "Cool down", body: "5-minute cool down", date: Date())
//        ],
//        reminders: [
//            ReminderModel(time: Date().addingTimeInterval(3600), message: "Time to exercise!"),
//            ReminderModel(time: Date().addingTimeInterval(7200), message: "Don't forget to exercise!")
//        ],
//        isReminder: true,
//        streak: 10,
//        lastLog: Date().addingTimeInterval(-86400) // Yesterday
//    )
//
//    static let habit2 = HabitModel(
//        title: "Read a Book",
//        body: "Read for 20 minutes",
//        days: [0, 2, 4, 6],
//        folder: nil,
//        emoji: "📚",
//        notes: [
//            NoteModel(title: "Pick a book", body: "Choose a new book to read", date: Date())
//        ],
//        reminders: [
//            ReminderModel(time: Date().addingTimeInterval(3600), message: "Time to read!"),
//            ReminderModel(time: Date().addingTimeInterval(7200), message: "Don't forget to read!")
//        ],
//        isReminder: true,
//        streak: 5,
//        lastLog: Date().addingTimeInterval(-43200) // 12 hours ago
//    )
//
//    static let habit3 = HabitModel(
//        title: "Meditation",
//        body: "Meditate for 15 minutes",
//        days: [0, 1, 2, 3, 4, 5, 6],
//        folder: nil,
//        emoji: "🧘",
//        notes: [
//            NoteModel(title: "Find a quiet place", body: "Ensure the environment is quiet", date: Date())
//        ],
//        reminders: [
//            ReminderModel(time: Date().addingTimeInterval(3600), message: "Time to meditate!"),
//            ReminderModel(time: Date().addingTimeInterval(7200), message: "Don't forget to meditate!")
//        ],
//        isReminder: true,
//        streak: 20,
//        lastLog: Date().addingTimeInterval(-86400) // Yesterday
//    )
//}
