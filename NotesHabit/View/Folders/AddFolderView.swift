//
//  AddFolder.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 14/07/24.
//

import SwiftUI

struct AddFolderView: View {
    @Binding var showModal: Bool
    @State private var folderTitle: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Folder Title", text: $folderTitle)
                }
            }
            .navigationBarTitle("Add Folder", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                presentationMode.wrappedValue.dismiss()
            }),trailing:Button("Done", action: {
                // TODO: Tambahin function untuk SaveHabit disini
                let folder = FolderModel(title: self.folderTitle)
                context.insert(folder)
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }
}

//#Preview {
//    AddFolderView()
//}
