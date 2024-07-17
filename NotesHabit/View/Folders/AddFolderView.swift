//
//  AddFolder.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//

import SwiftData
import SwiftUI

struct AddFolderView: View {
    @Environment(\.modelContext) var context
    @Environment(\.presentationMode) var presentationMode
    @State var folderTitle = ""
    @EnvironmentObject var folderViewModel: FolderViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Form {
                    TextField("Folder Title", text: $folderTitle)
                        .autocorrectionDisabled()
                }
            }
            .navigationBarTitle("Add Folder", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                .tint(.red),

                trailing: Button("Done", action: {
                    folderViewModel.add(item: FolderModel(title: folderTitle))
                    presentationMode.wrappedValue.dismiss()
                })
                .disabled(folderTitle == "")
            )
        }
    }
}

#Preview {
    AddFolderView()
}
