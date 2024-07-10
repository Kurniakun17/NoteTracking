//
//  FolderModel.swift
//  NoteTrack
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import Foundation
import SwiftData

@Model
class FolderModel: Identifiable {
    var id = UUID()
    var title: String
    
    @Relationship(deleteRule: .cascade, inverse: \NoteModel.folder)
    var notes: [NoteModel] = []

    @Relationship(deleteRule: .cascade, inverse: \GoalModel.folder)
    var goals: [GoalModel] = []

    init(id: UUID = UUID(), title: String, notes: [NoteModel], goals: [GoalModel]) {
        self.id = id
        self.title = title
        self.notes = notes
        self.goals = goals
    }
}
