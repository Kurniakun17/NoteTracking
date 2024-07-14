//
//  HabitDetail.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//

import SwiftData
import SwiftUI

struct HabitDetail: View {
    @Environment(\.modelContext) var context
    var habit: HabitModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(habit.notes, id: \.self) {
                    note in
                    NoteListItem(note: note)
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
                        Button(action: {
//                            isAddFolder = true
                        }) {
                            Image(systemName: "folder.badge.plus")
                        }

                        Spacer()

                        NavigationLink(
                            destination: AddNoteView()
                                .onAppear {
                                    let newNote = NoteModel(title: "", body: "", habit: habit)
                                    context.insert(newNote)
                                    habit.notes.append(newNote)
                                }) {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
            }
//            .sheet(isPresented: $isAddFolder, content: {
//                AddFolder(isAddFolder: $isAddFolder)
//            })
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
