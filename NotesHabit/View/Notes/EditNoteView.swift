//
//  EditNoteView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 12/07/24.
//

import SwiftData
import SwiftUI

struct EditNoteView: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @State var note: NoteModel
    @State var title: String
    @State var habit: String = "Empty"
    @State var bodyText: String
    @State var options = [
        "Empty",
        "Learn Swiftui 30 Minutes",
        "Learn Guitar 20 Minutes",
        "Learn Test 10 Minutes"
    ]

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .autocorrectionDisabled()
            Divider()
            TextEditor(text: $bodyText)
                .autocorrectionDisabled()
                .padding(.horizontal, 20)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu(content: {
                    Button(action: {}) {
                        HStack {
                            Text("Pin Note")
                            Spacer()
                            Image(systemName: "pin")
                        }
                    }
                    Menu(content: {
                        ForEach(habitViewModel.habits, id: \.self) {
                            habit in
                            Button(action: {
                                note.habit = habit
                                if title != "", bodyText != "" {
                                    habitViewModel.updateHabitLastLog(habit: habit)
                                }
                            }) {
                                Text(habit.title)
                            }
                        }
                    }, label: {
                        HStack {
                            Text("Add to Habit")
                            Spacer()
                            Image(systemName: "book.and.wrench")
                        }
                    })

                }, label: {
                    Image(systemName: "ellipsis.circle")
                })
            }
        }
        .onDisappear {
            if title == "" && bodyText == "" {
                noteViewModel.delete(item: note)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: title) {
            note.title = title
            note.updatedAt = Date()
            if let NoteHabit = note.habit {
                habitViewModel.updateHabitLastLog(habit: NoteHabit)
            }
        }

        .onChange(of: bodyText) {
            note.body = bodyText
            note.updatedAt = Date()
            if let NoteHabit = note.habit {
                habitViewModel.updateHabitLastLog(habit: NoteHabit)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NoteModel.self, configurations: config)
        let note = NoteModel(title: "testing", body: "Wow")

        return EditNoteView(note: note, title: note.title, bodyText: note.body)
            .modelContainer(container)
    } catch {
        fatalError("Text")
    }
}
