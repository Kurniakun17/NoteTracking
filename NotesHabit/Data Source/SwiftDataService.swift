//
//  SwiftDataService.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 15/07/24.
//

import Foundation
import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = SwiftDataService()

    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: HabitModel.self, NoteModel.self, FolderModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }

    func fetchNotes() -> [NoteModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<NoteModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchHabits() -> [HabitModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<HabitModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchFolders() -> [FolderModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<FolderModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func addNote(note: NoteModel) {
        modelContext.insert(note)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func addHabit(habit: HabitModel) {
        modelContext.insert(habit)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func addFolder(folder: FolderModel) {
        modelContext.insert(folder)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func deleteNote(note: NoteModel) {
        modelContext.delete(note)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func deleteHabit(habit: HabitModel) {
        modelContext.delete(habit)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func deleteFolder(folder: FolderModel) {
        modelContext.delete(folder)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
}
