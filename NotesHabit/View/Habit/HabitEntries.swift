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
    @State private var searchText: String = ""


    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: filteredNotes)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
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
    var filteredNotes: [NoteModel] {
        if searchText.isEmpty {
            return noteViewModel.notes.filter { $0.habit != nil }
        } else {
            return noteViewModel.notes.filter { $0.habit != nil && $0.title.localizedCaseInsensitiveContains(searchText) && $0.body.localizedCaseInsensitiveContains(searchText) }
        }
    }

}
