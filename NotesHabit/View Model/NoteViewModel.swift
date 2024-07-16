// NoteViewModel.swift

import Foundation
import SwiftData
import SwiftUI

class NoteViewModel: ObservableObject, Addable, Deletable {
    @Published var notes: [NoteModel]

    private let dataSource: SwiftDataService

    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        self.notes = dataSource.fetchNotes()
    }

    func addSampleNote() {
        let note = NoteModel(title: "Anime", body: "Kimetsu no Yaiba")

        dataSource.addNote(note: note)
        notes = dataSource.fetchNotes()
    }
    
    func add(item: NoteModel){
        dataSource.addNote(note: item)
        notes = dataSource.fetchNotes()
    }
    
    func delete(item: NoteModel){
        dataSource.deleteNote(note: item)
        notes = dataSource.fetchNotes()
    }
}
