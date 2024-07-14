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
    @State var habit: String = "Empty"
    @State var bodyText: String = ""
    @Query var notes: [NoteModel]
    @Query var habits: [HabitModel]

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
                        ForEach(habits, id: \.self) {
                            habit in
                            Button(action: {
                                notes.last?.habit = habit
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

        .onChange(of: title) {
            notes.last?.title = title
            notes.last?.updatedAt = Date()
            updateHabit()
        }

        .onChange(of: bodyText) {
            notes.last?.body = bodyText
            notes.last?.updatedAt = Date()
            updateHabit()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateHabit() {
        let habit = notes.last?.habit
        if habit != nil {
            if !Calendar.current.isDateInToday(habit!.lastLog!) {
                habit?.streak += 1
            }
            habit?.lastLog = Date()
        }
    }
}

#Preview {
    AddNoteView()
}
