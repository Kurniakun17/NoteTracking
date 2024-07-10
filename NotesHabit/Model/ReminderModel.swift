//
//  ReminderModel.swift
//  NoteTrack
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import Foundation
import SwiftData

@Model
class ReminderModel: Identifiable {
    var id = UUID()
    var time: Date
    var createdDate = Date()
    var updatedDate = Date()
    var deletedDate: Date?
    var goal: GoalModel?
    
    init(id: UUID = UUID(), time: Date, createdDate: Date = Date(), updatedDate: Date = Date(), deletedDate: Date? = nil, goal: GoalModel? = nil) {
        self.id = id
        self.time = time
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.deletedDate = deletedDate
        self.goal = goal
    }
}
