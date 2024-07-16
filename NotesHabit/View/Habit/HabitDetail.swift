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
            List {
                ForEach(habit.notes, id: \.self) {
                    note in
                    NoteListItem(note: note)
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                noteViewModel.delete(item: note)
                                if let index = habit.notes.firstIndex(where: {$0.id == note.id}){
                                    habit.notes.remove(at: index)
                                }
                            }) {
                                Image(systemName: "trash")
                            }.tint(.red)
                        }
                }
            }
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
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, NoteModel.self, configurations: config)

        SeedContainer(container: container)

        return HabitDetail(habit: HabitModel(title: "habit 1", body: "", days: [1, 2, 3], emoji: "👹", notes: [NoteModel(title: "Notes 1", body: "Body 1")], streak: 2))
            .modelContainer(container)

    } catch {
        fatalError("Error")
    }
}
