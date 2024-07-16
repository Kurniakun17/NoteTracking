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
//                NavigationLink(destination: CalendarView()) {
//                    HStack(spacing: 12) {
//                        Image(systemName: "calendar.circle.fill")
//                            .font(.system(size: 41))
//                            .foregroundStyle(.primaryRed)
//
//                        Text("Scheduled Habit")
//                        Spacer()
//                        Text(String(habitViewModel.habits.count))
//                            .foregroundColor(.gray)
//                    }
//                }

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
                        .foregroundColor(habit.streak == 0 ? .gray : .primaryRed)
                    Image(systemName: "flame.fill")
                        .foregroundStyle(habit.streak == 0 ? .gray : .primaryRed)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HabitModel.self, NoteModel.self, configurations: config)

        SeedContainer(container: container)

        return HabitsView()
            .modelContainer(container)

    } catch {
        fatalError("Error")
    }
}
