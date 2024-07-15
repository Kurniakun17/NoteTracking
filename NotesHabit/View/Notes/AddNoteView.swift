//
//  NewNoteView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 11/07/24.
//

// import RichEditorSwiftUI
// import RichTextKit
import SwiftData
import SwiftUI

struct AddNoteView: View {
    @State var title = ""
    @State var bodyText: String = ""
    @State var note = NoteModel(title: "", body: "")
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    var folder: FolderModel? = nil
    var habit: HabitModel? = nil

    @State var options = [
        "Empty",
        "Learn Swiftui 30 Minutes",
        "Learn Guitar 20 Minutes",
        "Learn Test 10 Minutes"
    ]

    var body: some View {
        VStack {
            TextField("New Notes", text: $title)
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

                                if(title != "" && bodyText != ""){
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
        .onChange(of: title) {
            note.title = title
            note.updatedAt = Date()
            if let habitExist = habit {
                habitViewModel.updateHabitLastLog(habit: habitExist)
            }
        }
        .onChange(of: bodyText) {
            note.body = bodyText
            note.updatedAt = Date()
            if let habitExist = habit {
                habitViewModel.updateHabitLastLog(habit: habitExist)
            }
        }

        .onDisappear {
            if let folderExist = folder {
                note.folder = folderExist
                folderExist.notes.append(note)
            }

            if let habitExist = habit {
                note.habit = habitExist
                habitExist.notes.append(note)
            }

            noteViewModel.addNote(note: note)
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateHabitLastLog() {
        if let habit = note.habit {
            if let lastLog = habit.lastLog {
                if !Calendar.current.isDateInToday(lastLog) {
                    habit.streak += 1
                }
            } else {
                habit.streak += 1
            }
            habit.lastLog = Date()
        }
    }
}
