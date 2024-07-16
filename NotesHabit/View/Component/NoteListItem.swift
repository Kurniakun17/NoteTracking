import SwiftData
import SwiftUI

struct NoteListItem: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    var note: NoteModel
    var folder: FolderModel?
    var habit: HabitModel?

    var body: some View {
        NavigationLink(destination: EditNoteView(note: note, title: note.title, bodyText: note.body)) {
            VStack(alignment: .leading) {
                Text(note.title == "" ? note.body : note.title)
                    .fontWeight(.bold)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                HStack {
                    Text(note.createdAt.formattedString())
                        .font(.subheadline)
                    Text(note.title == "" ? "No additional text" : note.body)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                .foregroundStyle(.gray)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(action: {
                withAnimation {
                    deleteNote(note: note)
                }
            }) {
                Image(systemName: "trash")
            }.tint(.red)
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                note.isFavourite.toggle()
            }) {
                Image(systemName: "pin")
            }.tint(.yellow)
        }
    }

    func deleteNote(note: NoteModel) {
        noteViewModel.delete(item: note)
        if let folderExist = folder {
            if let index = folderExist.notes.firstIndex(where: { $0 == note }) {
                folderExist.notes.remove(at: index)
            }
        }

        if let habitExist = habit {
            if let index = habitExist.notes.firstIndex(where: { $0 == note }) {
                habitExist.notes.remove(at: index)
            }
        }
    }
}
