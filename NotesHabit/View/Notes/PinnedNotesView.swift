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
    @State private var searchText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: filteredNotes)
        }
        .navigationTitle("Pinned")
        .sheet(isPresented: $isAddFolder, content: {
            AddFolderView()
        })
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
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
    }
    
    var filteredNotes: [NoteModel] {
        let pinnedNotes = noteViewModel.notes.filter {$0.isFavourite == true}

        if searchText.isEmpty {
            return pinnedNotes
        } else {
            return pinnedNotes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
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


////
////  UncategorizedView.swift
////  NotesHabit
////
////  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
////
//import SwiftData
//import SwiftUI
//
//struct PinnedNotesView: View {
//    @EnvironmentObject var folderViewModel: FolderViewModel
//    @EnvironmentObject var habitViewModel: HabitViewModel
//    @EnvironmentObject var noteViewModel: NoteViewModel
//    @State var isAddFolder = false
//    @State var isAddHabit = false
//    @State private var isPersonalNotesExpanded = true
//    @State private var isHabitDocumentationExpanded = true
//    @State private var searchText: String = ""
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            List {
//                Section(
//                    isExpanded: $isPersonalNotesExpanded,
//                    content: {
//                        ForEach(filteredNotesByFolder, id: \.self) { note in
//                            NoteListItem(note: note)
//                        }
//                    },
//                    header: {
//                        Text("Folders")
//                            .headerProminence(.increased)
//                    }
//                )
//                    
//                Section(
//                    isExpanded: $isHabitDocumentationExpanded,
//                    content: {
//                        ForEach(filteredNotesByHabit, id: \.self) { note in
//                            NoteListItem(note: note)
//                        }
//                    },
//                    header: {
//                        Text("Habits")
//                            .headerProminence(.increased)
//                    }
//                )
//            }
//            .listStyle(SidebarListStyle())
//        }
//        .navigationTitle("Pinned")
//        .sheet(isPresented: $isAddFolder, content: {
//            AddFolderView()
//        })
//        .toolbar {
//            ToolbarItem(placement: .bottomBar) {
//                HStack {
//                    Button(action: {
//                        isAddFolder = true
//                    }) {
//                        Image(systemName: "folder.badge.plus")
//                    }
//                        
//                    Spacer()
//                        
//                    NavigationLink(
//                        destination: AddNoteView()
//                    ) {
//                        Image(systemName: "square.and.pencil")
//                    }
//                }
//            }
//        }
//        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
//    }
//    var filteredNotesByFolder: [NoteModel] {
//        if searchText.isEmpty {
//            return noteViewModel.notes.filter { $0.folder != nil }
//        } else {
//            return noteViewModel.notes.filter {
//                $0.title.localizedCaseInsensitiveContains(searchText) ||
//                ($0.folder?.title.localizedCaseInsensitiveContains(searchText) ?? false) ||
//                ($0.habit?.title.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//        }
//    }
//    
//    var filteredNotesByHabit: [NoteModel] {
//        if searchText.isEmpty {
//            return noteViewModel.notes.filter { $0.habit != nil }
//        } else {
//            return noteViewModel.notes.filter {
//                $0.title.localizedCaseInsensitiveContains(searchText) ||
//                ($0.folder?.title.localizedCaseInsensitiveContains(searchText) ?? false) ||
//                ($0.habit?.title.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//        }
//    }
//
//}
//
//#Preview {
//    do {
//        @StateObject var noteViewModel = NoteViewModel(dataSource: .shared)
//        @StateObject var folderViewModel = FolderViewModel(datasource: .shared)
//        @StateObject var habitViewModel = HabitViewModel(dataSource: .shared)
//        
//        return PinnedNotesView()
//            .environmentObject(noteViewModel)
//            .environmentObject(folderViewModel)
//            .environmentObject(habitViewModel)
//        
//    } catch {
//        fatalError("Error")
//    }
//}
