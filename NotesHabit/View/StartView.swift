import SwiftData
import SwiftUI

struct StartView: View {
    @EnvironmentObject var folderViewModel: FolderViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @State var isAddFolder = false
    @State var isAddHabit = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    let personalNotesFolder = folderViewModel.folders.filter { $0.goals.count == 0 }
                    
                    FolderRow(destination: PersonalNotes(), title: "Personal Notes", count: personalNotesFolder.count)
                    
                    
                    FolderRow(destination: HabitsView(), title: "Habit Documentation", count: habitViewModel.habits.count)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Folders")
                .sheet(isPresented: $isAddFolder, content: {
                    AddFolderView()
                })
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                isAddFolder = true
                            }) {
                                Image(systemName: "folder.badge.plus")
                            }
                            
                            Spacer()

                            NavigationLink(
                                destination: AddNoteView()
                            ) {
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
