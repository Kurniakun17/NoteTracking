//
//  GoalsView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftData
import SwiftUI

struct HabitsView: View {
    @EnvironmentObject var habitViewModel: HabitViewModel
    @State var isAddNewNote = false
    @State var isAddHabit = false

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: Text("All Habits")) {
                    ForEach(habitViewModel.habits, id: \.self) {
                        habit in
                        HabitListItem(habit: habit)
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    habitViewModel.delete(item: habit)
                                }) {
                                    Image(systemName: "trash")
                                }.tint(.red)
                            }
                    }
                }
                .headerProminence(.increased)
            }
            // search habit
            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Habit Entries")
            .sheet(isPresented: $isAddHabit) {
                AddHabitView()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            isAddHabit = true
                        }) {
                            Image(systemName: "book.and.wrench")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct HabitListItem: View {
    var habit: HabitModel
    var body: some View {
        NavigationLink(destination: HabitDetail(habit: habit)) {
            HStack(spacing: 12) {
                Image(systemName: "book.and.wrench")

                Text(habit.title)
                Spacer()
                HStack(spacing: 8) {
                    Text(String(habit.streak))
                        .foregroundColor(habit.streak == 0 ? .gray : .orangeStreak)
                    Image(systemName: "flame.fill")
                        .foregroundStyle(habit.streak == 0 ? .gray : .orangeStreak)
                }
            }
        }
    }
}

#Preview {
    do {
        @StateObject var noteViewModel = NoteViewModel(dataSource: .shared)
        @StateObject var folderViewModel = FolderViewModel(datasource: .shared)
        @StateObject var habitViewModel = HabitViewModel(dataSource: .shared)
        
        return HabitsView()
            .environmentObject(noteViewModel)
            .environmentObject(folderViewModel)
            .environmentObject(habitViewModel)
        
    } catch {
        fatalError("Error")
    }
}
