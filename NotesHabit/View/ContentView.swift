//
//  ContentView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var folders: [FolderModel]
    @Query var habits: [HabitModel]
    @Environment(\.modelContext) var context

    var body: some View {
        StartView()
            .onAppear {
                requestNotificationPermissions()
                
                for habit in habits {
                    if let lastLog = habit.lastLog,
                       !Calendar.current.isDateInToday(lastLog) && !Calendar.current.isDateInYesterday(lastLog)
                    {
                        habit.streak = 0
                    }
                }
            }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, NoteModel.self, HabitModel.self, configurations: config)

        SeedContainer(container: container)

        return ContentView()
            .modelContainer(container)

    } catch {
        fatalError("Error")
    }
}
