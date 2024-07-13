//
//  NewNoteView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 11/07/24.
//

//import RichEditorSwiftUI
//import RichTextKit
import SwiftData
import SwiftUI

struct AddNoteView: View {
//    @ObservedObject var state: RichEditorState = .init(input: "HelloWorld")

//    @State var text = NSAttributedString(string: "Hai")
//    @StateObject var context = RichTextContext()
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
        })
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: title) {
            notes.last?.title = title
        }

        .onChange(of: bodyText) {
            notes.last?.body = bodyText
        }
    }
}

#Preview {
    AddNoteView()
}

//                RichTextEditor(text: $text, context: context) { _ in
//                }
//                .autocorrectionDisabled()
//                .focusedValue(\.richTextContext, context)
//                .padding(.horizontal, 20)
//
//                RichTextKeyboardToolbar(
//                    context: context,
//                    leadingButtons: { _ in Text("Hai") },
//                    trailingButtons: { _ in },
//                    formatSheet: { $0 })
