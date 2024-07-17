//
//  UncategorizedView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//
import SwiftData
import SwiftUI

struct UncategorizedView: View {
    @EnvironmentObject var noteViewModel: NoteViewModel

    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: noteViewModel.notes.filter { $0.folder == nil && $0.habit == nil })
//            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Uncategorized Notes")
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
