//
//  NoteModel.swift
//  NoteTrack
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import Foundation
import SwiftData

@Model
class NoteModel: Identifiable {
    var id = UUID()
    var title: String
    var body: String
    var isFavourite = false
    var folder: FolderModel?
    var createdAt = Date()
    var updatedAt = Date()
    var deletedAt: Date?
    var habit : HabitModel?

    init(id: UUID = UUID(), title: String, body: String, isFavourite: Bool = false, folder: FolderModel? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), deletedAt: Date? = nil, habit: HabitModel? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.isFavourite = isFavourite
        self.folder = folder
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.habit = habit
    }
}


