import SwiftData
import SwiftUI


struct MainView: View {
    @EnvironmentObject var folderViewModel: FolderViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @EnvironmentObject var noteViewModel: NoteViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var isAddFolder = false
    @State var isAddHabit = false
    @State private var isPersonalNotesExpanded = true
    @State private var isHabitDocumentationExpanded = true
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                // Summary Section
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        NavigationLink(destination: CalendarView()) {
                            SummaryItemView(title: "Scheduled", count: habitViewModel.habits.count, icon: "calendar.circle.fill")
                        }
                        .foregroundColor(.black)

                        NavigationLink(destination: PinnedNotesView()) {
                            SummaryItemView(title: "Pinned", count: noteViewModel.notes.filter { $0.isFavourite == true }.count, icon: "pin.circle.fill")
                        }
                        .foregroundColor(.black)
                    }

                    HStack(spacing: 16) {
                        NavigationLink(destination: AllNotesView()) {
                            SummaryItemView(title: "All Notes", count: noteViewModel.notes.count, icon: "tray.circle.fill")
                        }
                        .foregroundColor(.black)

                        NavigationLink(destination: HabitEntries()) {
                            SummaryItemView(title: "Habit Entries", count: noteViewModel.notes.filter { $0.habit != nil }.count, icon: "pencil.circle.fill")
                        }
                        .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.1))

                // List Personal Notes and Habit Documentation
                List {
                    Section(
                        isExpanded: $isPersonalNotesExpanded,
                        content: {
                            let uncategorizedNotes = noteViewModel.notes.filter { $0.habit == nil && $0.folder == nil }
                            FolderRow(destination: UncategorizedView(), title: "Uncategorized Notes", count: uncategorizedNotes.count)

                            ForEach(folderViewModel.folders, id: \.self) { folder in
                                FolderRow(destination: FolderDetail(folder: folder), title: folder.title, count: folder.notes.count)
                                    .swipeActions(edge: .trailing) {
                                        Button(action: {
                                            folderViewModel.delete(item: folder)
                                        }) {
                                            Image(systemName: "trash")
                                        }.tint(.red)
                                    }
                            }
                        },
                        header: {
                            Text("Folders")
                                .headerProminence(.increased)
                        }
                    )

                    Section(
                        isExpanded: $isHabitDocumentationExpanded,
                        content: {
                            ForEach(habitViewModel.habits, id: \.self) { habit in
                                HabitListItem(habit: habit)
                                    .swipeActions(edge: .trailing) {
                                        Button(action: {
                                            habitViewModel.delete(item: habit)
                                        }) {
                                            Image(systemName: "trash")
                                        }.tint(.red)
                                    }
                            }
                        },
                        header: {
                            Text("Habits")
                                .headerProminence(.increased)
                        }
                    )
                }
                .listStyle(SidebarListStyle())
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            }
            .navigationTitle("Noted")
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
                                    Image(systemName: "folder.badge.plus")
                                }
                            }
                        }, label: {
                            Image(systemName: "folder.badge.plus")
                        })

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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SummaryItemView: View {
    var title: String
    var count: Int
    var icon: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 36))
                    .frame(width: 40, height: 40)
                    .padding(.leading, 16)
                    .foregroundColor(.primaryRed)

                Spacer()

                Text("\(count)")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.trailing, 16)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .padding(.leading, 16)
                .padding(.bottom, 8)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        .padding(.vertical, 10)
        .frame(height: 100)
        .background(.secondElevation)
        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
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
        let container = try ModelContainer(for: HabitModel.self, NoteModel.self, HabitModel.self, configurations: config)

        SeedContainer(container: container)

        return ContentView()
            .modelContainer(container)

    } catch {
        fatalError("Error")
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

