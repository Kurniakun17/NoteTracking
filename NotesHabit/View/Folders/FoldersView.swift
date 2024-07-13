import SwiftUI
import SwiftData

struct FoldersView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: -2) {
                SearchBar()
                    .padding()
                
                List {
                    // TODO: ganti variabel count nya dengan Count isi folder yang sebenarnya
                    FolderRow(destination: PersonalNotes(), title: "Personal Notes", count: 20)
                    
                    FolderRow(destination: CalendarView(), title: "Building Habits (tent)", count: 15)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Folders")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                // TODO: Add action for add folder button
                            }) {
                                Image(systemName: "folder.badge.plus")
                            }
                            
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
