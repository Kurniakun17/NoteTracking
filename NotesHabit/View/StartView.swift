import SwiftData
import SwiftUI

struct StartView: View {
    @Environment(\.modelContext) var context
    @Query var notesFolder: [FolderModel]
    @Query var notes: [NoteModel]
    @Query var habits: [HabitModel]
    @State var isAddFolder = false
    @State var isAddHabit = false
    
    init() {
        let notesOnlyPredicate = #Predicate<FolderModel> {
            $0.goals.count == 0
        }
        
        _notesFolder = Query(filter: notesOnlyPredicate, sort: [], animation: .snappy)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    FolderRow(destination: PersonalNotes(), title: "Personal Notes", count: notesFolder.count)
                    
                    FolderRow(destination: HabitsView(), title: "Habit Documentation", count: habits.count)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Folders")
                .sheet(isPresented: $isAddFolder, content: {
                    AddFolderView()
                })
                .sheet(isPresented: $isAddHabit, content: {
                    AddHabitView()
                })
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Menu(content: {
                                     Button(action: {
                                         isAddHabit = true
                                     }) {
                                         HStack {
                                             Text("New Habit")
                                             Spacer()
                                             Image(systemName: "book.and.wrench")
                                         }
                                     }
                                
                                     Button(action: {
                                         isAddFolder = true

                                     }) {
                                         HStack {
                                             Text("New Folder")
                                             Spacer()
                                             Image(systemName: "folder")
                                         }
                                     }
                                
                                 },
                                 label: {
                                     Image(systemName: "folder.badge.plus")
                                 })
                            
                            Spacer()

                            NavigationLink(
                                destination: AddNoteView()
                                    .onAppear {
                                        context.insert(NoteModel(title: "", body: ""))
                                    }) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
            }
        }
   
        .navigationViewStyle(StackNavigationViewStyle())
        .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
    }
}

struct FolderRow<Destination: View>: View {
    var destination: Destination
    var title: String
    var count: Int
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: "folder")
                Text(title)
                Spacer()
                Text("\(count)")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        SeedContainer(container: container)
        
        return StartView()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}
