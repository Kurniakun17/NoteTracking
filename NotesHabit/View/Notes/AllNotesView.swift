//
//  UncategorizedView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//
import SwiftData
import SwiftUI

struct AllNotesView: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: noteViewModel.filteredNotes)
                .searchable(text: $noteViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("All Notes")
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
