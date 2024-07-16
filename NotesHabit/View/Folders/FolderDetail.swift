//
//  FolderView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 13/07/24.
//

import SwiftUI

struct FolderDetail: View {
    var folder: FolderModel
    @EnvironmentObject var noteViewModel: NoteViewModel

    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: folder.notes.sorted { $0.createdAt > $1.createdAt })
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(folder.title)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {

                            Spacer()

                            NavigationLink(
                                destination: AddNoteView(folder: folder)
                            ) {
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
