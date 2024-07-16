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
            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Uncategorized Notes")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
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
