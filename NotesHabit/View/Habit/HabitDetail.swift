//
//  HabitDetail.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//

import SwiftData
import SwiftUI

struct HabitDetail: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    var habit: HabitModel

    var body: some View {
        VStack(alignment: .leading) {
            NotesList(filteredNotes: habit.notes)
                .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                .listStyle(InsetGroupedListStyle())
                .navigationTitle(habit.title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Edit", action: {})
                    }

                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Spacer()

                            NavigationLink(
                                destination: AddNoteView(habit: habit)
                            ) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    do {
        @StateObject var noteViewModel = NoteViewModel(dataSource: .shared)
        @StateObject var folderViewModel = FolderViewModel(datasource: .shared)
        @StateObject var habitViewModel = HabitViewModel(dataSource: .shared)
        
        return HabitDetail(habit: HabitModel(title: "habit 1", body: "", days: [1, 2, 3], emoji: "👹", notes: [NoteModel(title: "Notes 1", body: "Body 1")], streak: 2))
            .environmentObject(noteViewModel)
            .environmentObject(folderViewModel)
            .environmentObject(habitViewModel)
        
    } catch {
        fatalError("Error")
    }
}
