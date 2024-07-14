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
                    Button(action: {}) {
                        HStack {
                            Text("Add to Habit")
                            Spacer()
                            Image(systemName: "book.and.wrench")
                        }
                    }

                }, label: {
                    Image(systemName: "ellipsis.circle")

                })
            }
        }
//        .searchable(text: .con`stant(""), placement: .navigationBarDrawer(displayMode: .))

        .onChange(of: title) {
            notes.last?.title = title
            notes.last?.updatedAt = Date()
        }

        .onChange(of: bodyText) {
            notes.last?.body = bodyText
            notes.last?.updatedAt = Date()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddNoteView()
}
