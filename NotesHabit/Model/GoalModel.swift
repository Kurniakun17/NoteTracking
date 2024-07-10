//
//  GoalModel.swift
//  NoteTrack
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import Foundation
import SwiftData

@Model
class GoalModel: Identifiable {
    var id = UUID()
    var title: String
    var body: String
    var days: Set<Int>
    var startDate = Date()
    var folder: FolderModel?

    @Relationship(deleteRule: .cascade, inverse: \NoteModel.goal)
    var notes: [NoteModel] = []

    @Relationship(deleteRule: .cascade, inverse: \ReminderModel.goal)
    var reminders: [ReminderModel] = []
    var isReminder = false
    var createAt = Date()
    var updateAt = Date()
    var deleteAt: Date?

    var noteHistory: [Date: Int] = [:]

    init(id: UUID = UUID(), title: String, body: String, days: Set<Int>, startDate: Date = Date(), folder: FolderModel? = nil, notes: [NoteModel], reminders: [ReminderModel], isReminder: Bool = false, createAt: Date = Date(), updateAt: Date = Date(), deleteAt: Date? = nil, noteHistory: [Date: Int]) {
        self.id = id
        self.title = title
        self.body = body
        self.days = days
        self.startDate = startDate
        self.folder = folder
        self.notes = notes
        self.reminders = reminders
        self.isReminder = isReminder
        self.createAt = createAt
        self.updateAt = updateAt
        self.deleteAt = deleteAt
        self.noteHistory = noteHistory
    }
}
