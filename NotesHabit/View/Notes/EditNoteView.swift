//
//  EditNoteView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 12/07/24.
//

import SwiftData
import SwiftUI

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var folderViewModel: FolderViewModel
    @FocusState private var isKeyboardEnabled: Bool
    @State var note: NoteModel
    @State var title: String
    @State var habit: String = "Empty"
    @State var bodyText: String
    @State var isDone = false
    @State var isDelete = false
    @State var options = [
        String(localized: "Empty"),
        String(localized: "Learn Swiftui 30 Minutes"),
        String(localized: "Learn Guitar 20 Minutes"),
        String(localized: "Learn Test 10 Minutes")
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
        .onDisappear {
            if (title == "" && bodyText == "") || isDelete {
                deleteNote()
            }
        }
    }
    
    func deleteNote(){
        noteViewModel.delete(item: note)
        
        if let folderExist = note.folder {
            folderViewModel.deleteNote(folder: folderExist, item: note)

        }
        
        if let habitExist = note.habit {
                habitViewModel.deleteNote(habit: habitExist, item: note)
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: NoteModel.self, configurations: config)
//        let note = NoteModel(title: "testing", body: "Wow")
//
//        return EditNoteView(note: note, title: note.title, bodyText: note.body)
//            .modelContainer(container)
//    } catch {
//        fatalError("Text")
//    }
//}
