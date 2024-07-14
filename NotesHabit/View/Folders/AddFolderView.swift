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

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                HStack {
                    TextField("Folder Title", text: $folderTitle)
                        .autocorrectionDisabled()
                }
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                Spacer()
            }
            .padding()
            .navigationBarTitle("Add Folder", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                .tint(.red),

                trailing: Button("Done", action: {
                    context.insert(FolderModel(title: folderTitle))
                    presentationMode.wrappedValue.dismiss()
                }))
        }
    }
}

#Preview {
    AddFolderView()
}
