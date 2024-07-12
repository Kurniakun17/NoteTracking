//
//  EditNoteView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 12/07/24.
//

import SwiftData
import SwiftUI

struct EditNoteView: View {
    @State var note: NoteModel
    @State var text = NSAttributedString(string: "Hai")
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
        NavigationView(content: {
            VStack {
                TextField("Title", text: $title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                    .autocorrectionDisabled()

                HStack {
                    Image(systemName: "arrowtriangle.down.circle")
                        .foregroundStyle(.black.opacity(0.8))
                    Text("Habit")
                        .foregroundStyle(.black.opacity(0.8))
                    Picker(selection: $habit, label: EmptyView()) {
                        ForEach(options, id: \.self) {
                            opt in
                            Text(opt)
                                .foregroundStyle(.white)
                        }
                    }
                    .labelsHidden()
                    .tint(habit == "Empty" ? .black.opacity(0.8) : .black)
                    Spacer()
                }
                .padding(.horizontal, 20)

                Divider()

                TextEditor(text: $bodyText)
                    .autocorrectionDisabled()
                    .padding(.horizontal, 20)

                Spacer()
            }
            .onChange(of: text) {}
        })
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: title) {
            note.title = title
        }

        .onChange(of: bodyText) {
            note.body = bodyText
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
    }
    catch {
        fatalError("Text")
    }
}
