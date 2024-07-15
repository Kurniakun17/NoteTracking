//
//  FolderViewModel.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 15/07/24.
//

import Foundation

class FolderViewModel: ObservableObject {
    @Published var folders: [FolderModel]

    private let datasource: SwiftDataService

    init(datasource: SwiftDataService) {
        self.datasource = datasource
        self.folders = datasource.fetchFolders()
    }

    func addFolder(folder: FolderModel) {
        datasource.addFolder(folder: folder)
        folders = datasource.fetchFolders()
    }

    func deleteFolder(folder: FolderModel) {
        datasource.deleteFolder(folder: folder)
        folders = datasource.fetchFolders()
    }
}
