//
//  UncategorizedView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//
import SwiftData
import SwiftUI

struct HabitEntries: View {
    @EnvironmentObject var noteViewModel: NoteViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                let uncategorizedNotes = noteViewModel.notes.filter { $0.habit != nil }
                let sortedNotes = uncategorizedNotes.sorted(by: { $0.createdAt > $1.createdAt })
                let todayNotes = sortedNotes.filter { Calendar.current.isDateInToday($0.createdAt) }
                let previous7DaysNotes = sortedNotes.filter { isInLast7Days($0.createdAt) && !Calendar.current.isDateInToday($0.createdAt) }
                let previous30DaysNotes = sortedNotes.filter { isInLast30Days($0.createdAt) && !Calendar.current.isDateInToday($0.createdAt) }
                let otherNotes = sortedNotes.filter { !Calendar.current.isDateInToday($0.createdAt) && !isInLast30Days($0.createdAt) }

                if !todayNotes.isEmpty {
                    Section(header: Text("Today")) {
                        ForEach(todayNotes, id: \.self) { note in
                            NoteListItem(note: note)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        noteViewModel.delete(item: note)
                                    }) {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                }
                        }
                    }
                    .headerProminence(.increased)
                }

                if !previous7DaysNotes.isEmpty {
                    Section(header: Text("Preivous 7 Days")) {
                        ForEach(previous7DaysNotes, id: \.self) {
                            note in NoteListItem(note: note)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        noteViewModel.delete(item: note)
                                    }) {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                }
                        }
                    }.headerProminence(.increased)
                }

                if !previous30DaysNotes.isEmpty {
                    Section(header: Text("Previous 30 Days")) {
                        ForEach(previous30DaysNotes, id: \.self) { note in
                            NoteListItem(note: note)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        noteViewModel.delete(item: note)
                                    }) {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                }
                        }
                    }
                    .headerProminence(.increased)
                }

                ForEach(groupNotesByMonth(notes: otherNotes), id: \.self) { groupedNotes in
                    Section(header: Text(groupedNotes.month)) {
                        ForEach(groupedNotes.notes, id: \.self) { note in
                            NoteListItem(note: note)
                        }
                    }
                    .headerProminence(.increased)
                }
            }
            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Habit Entries")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit", action: {})
                }

                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            noteViewModel.addSampleNote()
                        }) {
                            Image(systemName: "plus")
                        }

                        Spacer()

                        NavigationLink(
                            destination: AddNoteView()
                        ) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
            }
        }
    }
}
