//
//  EditNoteView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 12/07/24.
//

import SwiftData
import SwiftUI

struct EditNoteView: View {
    @Query var habits: [HabitModel]
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
                        ForEach(habits, id: \.self) {
                            habit in
                            Button(action: {
                                note.habit = habit
//                                TODO: Update last log and streak
//                                habit.lastLog = ()
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

        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: title) {
            note.title = title
            note.updatedAt = Date()
            updateHabitLastLog()
        }

        .onChange(of: bodyText) {
            note.body = bodyText
            note.updatedAt = Date()
            updateHabitLastLog()
        }
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
