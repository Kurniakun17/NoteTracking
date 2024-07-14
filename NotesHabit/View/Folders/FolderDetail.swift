//
//  FolderView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/07/24.
//

import SwiftUI

struct FolderDetail: View {
    var folder: FolderModel
    @Environment(\.modelContext) var context

    var body: some View {
        VStack(alignment: .leading) {
            List {
                let sortedNotes = folder.notes.sorted(by: { $0.createdAt > $1.createdAt })
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
                                        if let index = folder.notes.firstIndex(where: { $0 == note }) {
                                            folder.notes.remove(at: index)
                                            context.delete(note)
                                        }

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
                        }
                    }.headerProminence(.increased)
                }

                if !previous30DaysNotes.isEmpty {
                    Section(header: Text("Previous 30 Days")) {
                        ForEach(previous30DaysNotes, id: \.self) { note in
                            NoteListItem(note: note)
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
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(folder.title)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "folder.badge.plus")
                        }

                        Spacer()

                        NavigationLink(
                            destination: AddNoteView()
                                .onAppear {
                                    let newNote = NoteModel(title: "", body: "", folder: folder)
                                    context.insert(newNote)
                                    folder.notes.append(newNote)
                                }) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
            }
        }
        .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
    }
}

struct GroupedNotes: Hashable {
    let month: String
    let notes: [NoteModel]
}

struct NoteListItem: View {
    var note: NoteModel
    var body: some View {
        NavigationLink(destination: EditNoteView(note: note, title: note.title, bodyText: note.body)) {
            VStack(alignment: .leading) {
                Text(note.title)
                    .fontWeight(.bold)
                    .font(.headline)
                HStack {
                    Text(note.createdAt.formattedString())
                        .font(.subheadline)
                    Text(note.body)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        }
    }
}
