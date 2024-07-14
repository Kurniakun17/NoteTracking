import SwiftUI
import SwiftData

struct FoldersView: View {
    @State private var showModal = false
    @Query(animation: .snappy) private var habits: [HabitModel]
    @Query(animation: .snappy) private var notes: [NoteModel]
    @Query(animation: .snappy) private var folders: [FolderModel]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: -2) {
                SearchBar()
                    .padding()
                
                List {
                    // TODO: ganti variabel count nya dengan Count isi folder yang sebenarnya
                    FolderRow(destination: PersonalNotes(), title: "Personal Notes", count: habits.count)
                    
                    FolderRow(destination: CalendarView(), title: "Building Habits (tent)", count: habits.count)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Folders")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Menu {
                                Button(action: {
                                    // Action for option 1
                                    self.showModal = true
                                }) {
                                    Text("Add Habit")
                                }
                                Button(action: {
                                    // Action for option 2
                                    print("Option 2 selected")
                                }) {
                                    Text("Add Folder")
                                }
                            } label: {
                                Image(systemName: "folder.badge.plus")
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                            
                            Button(action: {
                                // TODO: Add action for add notes
                            }) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                AddHabitView(showModal: self.$showModal)
            }
        }
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
    do
    {
        var config = ModelConfiguration(isStoredInMemoryOnly: true)
        var container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        return FoldersView()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}
