//
//  UncategorizedView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//
import SwiftData
import SwiftUI

struct PinnedNotesView: View {
    @EnvironmentObject var folderViewModel: FolderViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var noteViewModel: NoteViewModel
    @State var isAddFolder = false
    @State var isAddHabit = false
    @State private var isPersonalNotesExpanded = true
    @State private var isHabitDocumentationExpanded = true

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(
                    isExpanded: $isPersonalNotesExpanded,
                    content: {
                        ForEach(noteViewModel.notes.filter { $0.folder != nil }, id: \.self) { note in
                            NoteListItem(note: note)
                        }
                    },
                    header: {
                        Text("Folders")
                            .headerProminence(.increased)
                    }
                )
                    
                Section(
                    isExpanded: $isHabitDocumentationExpanded,
                    content: {
                        ForEach(noteViewModel.notes.filter { $0.habit != nil }, id: \.self) { note in
                            NoteListItem(note: note)
                        }
                    },
                    header: {
                        Text("Habits")
                            .headerProminence(.increased)
                    }
                )
            }
            .listStyle(SidebarListStyle())
        }
        .navigationTitle("Pinned")
        .sheet(isPresented: $isAddFolder, content: {
            AddFolderView()
        })
        .toolbar {
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
        .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
    }
}

#Preview {
    do {
        @StateObject var noteViewModel = NoteViewModel(dataSource: .shared)
        @StateObject var folderViewModel = FolderViewModel(datasource: .shared)
        @StateObject var habitViewModel = HabitViewModel(dataSource: .shared)
        
        return PinnedNotesView()
            .environmentObject(noteViewModel)
            .environmentObject(folderViewModel)
            .environmentObject(habitViewModel)
        
    } catch {
        fatalError("Error")
    }
}
