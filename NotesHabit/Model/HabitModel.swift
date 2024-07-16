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
    @Relationship(deleteRule: .cascade, inverse: \NoteModel.habit)
    var notes: [NoteModel] = []
    var time: Date?
    var isReminder = false
    var createAt = Date()
    var updateAt = Date()
    var deleteAt: Date?
    var streak: Int = 0

    var lastLog: Date?

    init(id: UUID = UUID(), title: String, body: String, days: Set<Int>, startDate: Date = Date(), folder: FolderModel? = nil, emoji: String, notes: [NoteModel] = [], time: Date? = nil, isReminder: Bool = false, createAt: Date = Date(), updateAt: Date = Date(), deleteAt: Date? = nil, streak: Int = 0, lastLog: Date? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.days = days
        self.startDate = startDate
        self.folder = folder
        self.emoji = emoji
        self.notes = notes
        self.time = time
        self.isReminder = isReminder
        self.createAt = createAt
        self.updateAt = updateAt
        self.deleteAt = deleteAt
        self.streak = streak
        self.lastLog = lastLog
    }
}
