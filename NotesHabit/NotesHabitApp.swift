//
//  NotesHabitApp.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import SwiftUI

@main
struct NotesHabitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[NoteModel.self, ])
    }
}
