//
//  PersonalNotes.swift
//  NotesHabit
//
//  Created by Natasha Hartanti Winata on 13/07/24.
//

import SwiftData
import SwiftUI

struct PersonalNotes: View {
    @Query var notesFolder: [FolderModel]
    @Query var uncategorizedNotes: [NoteModel]
    @Environment(\.modelContext) var context
    @State var isAddNewNote = false
    @State var isAddFolder = false

    init() {
        let notesOnlyPredicate = #Predicate<FolderModel> {
            $0.goals.count == 0
        }

        _notesFolder = Query(filter: notesOnlyPredicate, sort: [], animation: .snappy)

        let uncategorizedPredicate = #Predicate<NoteModel> {
            $0.folder == nil && $0.habit == nil
        }

        _uncategorizedNotes = Query(filter: uncategorizedPredicate, sort: [], animation: .snappy)
    }

    var body: some View {
        VStack(alignment: .leading) {
            List {
                FolderRow(destination: UncategorizedView(), title: String(localized: "Uncategorized Notes"), count: uncategorizedNotes.count)
                ForEach(notesFolder, id: \.self) {
                    folder in
                    FolderRow(destination: FolderDetail(folder: folder), title: folder.title, count: folder.notes.count)
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
                                .onAppear {
                                    context.insert(NoteModel(title: "", body: ""))
                                }) {
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

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, configurations: config)

        SeedContainer(container: container)

        return PersonalNotes()
            .modelContainer(container)

    } catch {
        fatalError("Error")
    }
}
