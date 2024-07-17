//
//  SearchResultsView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 17/07/24.
//

import SwiftUI

struct SearchResultsView: View {
    @State var searchText: String
    @EnvironmentObject var folderViewModel: FolderViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var noteViewModel: NoteViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: filteredNotes)
            Spacer()
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Search Results")
    }
    
    var filteredNotes: [NoteModel] {
        let allNotes = noteViewModel.notes

        if searchText.isEmpty {
            return allNotes
        } else {
            return allNotes.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.body.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
