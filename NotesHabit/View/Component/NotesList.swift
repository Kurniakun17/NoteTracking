//
//  NotesList.swift
//  NotesHabit
//
//  Created by Natasha Hartanti Winata on 16/07/24.
//

import SwiftUI

struct NotesList: View {
    var filteredNotes: [NoteModel]
    var folder: FolderModel?
    var habit: HabitModel?

    var body: some View {
        List {
            let sortedNotes = filteredNotes.sorted(by: { $0.createdAt > $1.createdAt })
            let todayNotes = sortedNotes.filter { Calendar.current.isDateInToday($0.createdAt) }
            let previous7DaysNotes = sortedNotes.filter { isInLast7Days($0.createdAt) && !Calendar.current.isDateInToday($0.createdAt) }
            let previous30DaysNotes = sortedNotes.filter { isInLast30Days($0.createdAt) && !Calendar.current.isDateInToday($0.createdAt) }
            let otherNotes = sortedNotes.filter { !Calendar.current.isDateInToday($0.createdAt) && !isInLast30Days($0.createdAt) }

            if !todayNotes.isEmpty {
                Section(header: Text("Today")) {
                    ForEach(todayNotes, id: \.self) { note in
                        NoteListItem(note: note, folder: folder, habit: habit)
                            .transition(.slide)
                    }
                }
                .headerProminence(.increased)
            }

            if !previous7DaysNotes.isEmpty {
                Section(header: Text("Previous 7 Days")) {
                    ForEach(previous7DaysNotes, id: \.self) {
                        note in
                        NoteListItem(note: note, folder: folder, habit: habit)
                    }
                }.headerProminence(.increased)
            }

            if !previous30DaysNotes.isEmpty {
                Section(header: Text("Previous 30 Days")) {
                    ForEach(previous30DaysNotes, id: \.self) { note in
                        NoteListItem(note: note, folder: folder, habit: habit)
                    }
                }
                .headerProminence(.increased)
            }

            ForEach(groupNotesByMonth(notes: otherNotes), id: \.self) { groupedNotes in
                Section(header: Text(groupedNotes.month)) {
                    ForEach(groupedNotes.notes, id: \.self) { note in
                        NoteListItem(note: note, folder: folder, habit: habit)
                    }
                }
                .headerProminence(.increased)
            }
        }
    }
}
