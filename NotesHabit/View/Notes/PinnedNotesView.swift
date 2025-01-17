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
