//
//  SeedContainer.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/07/24.
//

import Foundation
import SwiftData

@MainActor func SeedContainer(container: ModelContainer) {
    for num in 1 ... 3 {
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 6
        dateComponents.day = 1

        var dateComponents2 = DateComponents()
        dateComponents2.year = 2024
        dateComponents2.month = 4
        dateComponents2.day = 1

        
        let calendar = Calendar.current

        let notes = [
            NoteModel(title: "best anime \(num)", body: "kimetsu no yaiba"),
            NoteModel(title: "best cat \(num)", body: "sukma", createdAt: calendar.date(from: dateComponents) ?? Date()),
            NoteModel(title: "best dog \(num)", body: "sukma", createdAt: calendar.date(from: dateComponents2) ?? Date()),
            NoteModel(title: "best bootcamp \(num)", body: "apple developer academy"),
        ]
        let folder = FolderModel(title: "Folder + \(num)", notes: notes)
        container.mainContext.insert(folder)
    }
    
    for num in 1 ... 4 {
        container.mainContext
            .insert(HabitModel(title: "habit \(num)", body: "", days: [1, 2, 3], emoji: "👹", notes: [NoteModel(title: "Notes \(num)", body: "Body \(num)")], streak: 2))
    }

}
