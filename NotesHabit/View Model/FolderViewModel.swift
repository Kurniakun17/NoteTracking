//
//  FolderViewModel.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 15/07/24.
//

import Foundation

class FolderViewModel: ObservableObject, Addable, Deletable {
    @Published var folders: [FolderModel]

    private let datasource: SwiftDataService

    init(datasource: SwiftDataService) {
        self.datasource = datasource
        self.folders = datasource.fetchFolders()
    }

    func add(item: FolderModel) {
        datasource.addFolder(folder: item)
        folders = datasource.fetchFolders()
    }

    func delete(item: FolderModel) {
        datasource.deleteFolder(folder: item)
        folders = datasource.fetchFolders()
    }
    
    
    func deleteNote(folder: FolderModel, item: NoteModel) {
        if let index = folder.notes.firstIndex(where: { $0 == item }) {
            folder.notes.remove(at: index)
        }
    }

}
