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
    var emoji: String
    var isFavourite = false
    var folder: FolderModel?
    var createdAt = Date()
    var updatedAt = Date()
    var deletedAt: Date?
    var goal : GoalModel?

    init(id: UUID = UUID(), title: String, body: String, emoji: String, isFavourite: Bool = false, folder: FolderModel? = nil, createdAt: Date = Date(), updatedAt: Date = Date(), deletedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.body = body
        self.emoji = emoji
        self.isFavourite = isFavourite
        self.folder = folder
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
