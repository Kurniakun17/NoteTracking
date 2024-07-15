// NoteViewModel.swift

import Foundation
import SwiftData
import SwiftUI

class NoteViewModel: ObservableObject {
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
    
    func addNote(note: NoteModel){
        dataSource.addNote(note: note)
        notes = dataSource.fetchNotes()
    }
    
    func deleteNote(note: NoteModel){
        dataSource.deleteNote(note: note)
        notes = dataSource.fetchNotes()
    }
}
