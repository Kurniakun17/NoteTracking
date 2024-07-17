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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @FocusState private var isKeyboardEnabled: Bool
    @State var title = ""
    @State var bodyText: String = ""
    @State var note = NoteModel(title: "", body: "")
    @State var isDone = false
    @State var isDelete = false
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
                .focused($isKeyboardEnabled)
            Divider()
            TextEditor(text: $bodyText)
                .autocorrectionDisabled()
                .padding(.horizontal, 20)
                .disabled(title == "")
                .focused($isKeyboardEnabled)

            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack{
                    Menu(content: {
                        Button(action: {}) {
                            HStack {
                                Text("Pin Note")
                                Spacer()
                                Image(systemName: "pin")
                            }
                        }

                        Button(action: {}) {
                            HStack {
                                Text("Find in Note")
                                Spacer()
                                Image(systemName: "magnifyingglass")
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
                        
                        
                        Button(action: {
                            withAnimation{
                                noteViewModel.delete(item: note)
                            }
                            isDelete = true
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            HStack {
                                Text("Delete")
                                Spacer()
                                Image(systemName: "trash")
                            }
                            .foregroundStyle(.red)
                        }
                        
                      
                        

                    }, label: {
                        Image(systemName: "ellipsis.circle")
                    })
                    
                    if(!isDone){
                        Button(action: {
                            isKeyboardEnabled = false
                            withAnimation{
                                isDone = true
                            }
                        }) {
                            Text("Done")
                        }
                        .transition(.scale)
                    }
                }
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
            if title != "" {
                if let folderExist = folder {
                    note.folder = folderExist
                    folderExist.notes.append(note)
                }

                if let habitExist = habit {
                    note.habit = habitExist
                    habitExist.notes.append(note)
                }

                if(!isDelete){
                    withAnimation {
                        noteViewModel.add(item: note)
                    }
                }
            
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
