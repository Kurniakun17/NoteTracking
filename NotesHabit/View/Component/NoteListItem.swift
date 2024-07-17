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
                    Text(note.updatedAt.formattedString())
                        .font(.subheadline)
                    Text(note.title == "" ? "No additional text" : note.body)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                
                if(note.habit != nil || note.folder != nil){
                    HStack{
                        Image(systemName: note.habit != nil ? "book.and.wrench" : "folder")
                        Text(note.habit != nil ? note.habit!.title : note.folder!.title)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)

                }
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
                withAnimation{
                    note.isFavourite.toggle()
                }
            }) {
                Image(systemName:  note.isFavourite == false ? "pin" : "pin.slash")
            }.tint(.orange)
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
