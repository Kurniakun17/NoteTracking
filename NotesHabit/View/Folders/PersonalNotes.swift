//
//  PersonalNotes.swift
//  NotesHabit
//
//  Created by Natasha Hartanti Winata on 13/07/24.
//

import SwiftData
import SwiftUI

struct PersonalNotes: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var folderViewModel: FolderViewModel
    @Environment(\.modelContext) var context
    @State var isAddNewNote = false
    @State var isAddFolder = false

    var body: some View {
        VStack(alignment: .leading) {
            List {
                let uncategorizedNotes = noteViewModel.notes.filter { $0.habit == nil && $0.folder == nil }
                FolderRow(destination: UncategorizedView(), title: "Uncategorized Notes", count: uncategorizedNotes.count)

                ForEach(folderViewModel.folders, id: \.self) {
                    folder in
                    FolderRow(destination: FolderDetail(folder: folder), title: folder.title, count: folder.notes.count)
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                folderViewModel.deleteFolder(folder: folder)
                            }) {
                                Image(systemName: "trash")
                            }.tint(.red)
                        }
                }
            }
            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Personal Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit", action: {})
                }

                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            isAddFolder = true
                        }) {
                            Image(systemName: "folder.badge.plus")
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
            .sheet(isPresented: $isAddFolder, content: {
                AddFolderView()
            })
        }
    }
}

//
// #Preview {
//    do {
//        @MainActor
//        @StateObject var noteViewModel = NoteViewModel(dataSource: .shared)
//
//        return PersonalNotes()
//            .environmentObject(noteViewModel)
//
//    } catch {
//        fatalError("Error")
//    }
// }
