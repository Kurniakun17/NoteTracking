//
//  UncategorizedView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//
import SwiftData
import SwiftUI

struct UncategorizedView: View {
    @Query var uncategorizedNotes: [NoteModel]
    @Environment(\.modelContext) var context

    init() {
        let uncategorizedPredicate = #Predicate<NoteModel> {
            $0.folder == nil && $0.habit == nil
        }

        _uncategorizedNotes = Query(filter: uncategorizedPredicate, sort: [], animation: .snappy)
    }

    var body: some View {
        VStack(alignment: .leading) {
            List {
                let sortedNotes = uncategorizedNotes.sorted(by: { $0.createdAt > $1.createdAt })
                let todayNotes = sortedNotes.filter { Calendar.current.isDateInToday($0.createdAt) }
                let previous7DaysNotes = sortedNotes.filter { isInLast7Days($0.createdAt) && !Calendar.current.isDateInToday($0.createdAt) }
                let previous30DaysNotes = sortedNotes.filter { isInLast30Days($0.createdAt) && !Calendar.current.isDateInToday($0.createdAt) }
                let otherNotes = sortedNotes.filter { !Calendar.current.isDateInToday($0.createdAt) && !isInLast30Days($0.createdAt) }

                if !todayNotes.isEmpty {
                    Section(header: Text("Today")) {
                        ForEach(todayNotes, id: \.self) { note in
                            NoteListItem(note: note)
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
            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Uncategorized Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit", action: {})
                }

                ToolbarItem(placement: .bottomBar) {
                    HStack {
//                        Button(action: {
//                            // TODO: Add action for add folder button
//                        }) {
//                            Image(systemName: "folder.badge.plus")
//                        }

                        Spacer()

                        NavigationLink(
                            destination: AddNoteView()
                                .onAppear {
                                    context.insert(NoteModel(title: "", body: ""))
                                }) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
            }
        }
    }
}
