//
//  GoalsView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftData
import SwiftUI

struct HabitsView: View {
    @Query var notesFolder: [FolderModel]
    @Query var habits: [HabitModel]
    @Query var uncategorizedNotes: [NoteModel]
    @Environment(\.modelContext) var context
    @State var isAddNewNote = false
    @State var isAddHabit = false

    var body: some View {
        VStack(alignment: .leading) {
            List {
                NavigationLink(destination: CalendarView()) {
                    HStack(spacing: 12) {
                        Image(systemName: "calendar.circle.fill")
                            .font(.system(size: 41))
                            .foregroundStyle(.primaryRed)

                        Text("Scheduled Habit")
                        Spacer()
                        Text(String(habits.count))
                            .foregroundColor(.gray)
                    }
                }

                Section(header: Text("All Habits")) {
                    ForEach(habits, id: \.self) {
                        habit in
                        HabitListItem(habit: habit)
                    }
                }
                .headerProminence(.increased)
            }
            .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Habit Documentation")
            .sheet(isPresented: $isAddHabit) {
                AddHabitView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit", action: {})
                }

                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            isAddHabit = true
                        }) {
                            Image(systemName: "folder.badge.plus")
                        }

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
}

struct HabitListItem: View {
    var habit: HabitModel
    var body: some View {
        NavigationLink(destination: HabitDetail(habit: habit)) {
            HStack(spacing: 12) {
                Image(systemName: "calendar")

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

struct ModalView: View {
    // Binding to the state variable to dismiss the modal
    @Binding var showModal: Bool
    @State private var habitTitle = ""
    @State private var selectedEmoji = ""
    @State private var descriptions = ""
    @State private var startDate = Date()
    @State private var repeatDays: [Bool] = Array(repeating: false, count: 7)
    @State private var remindersEnabled = false
    @Environment(\.modelContext) private var context

    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    var daysSet: Set = [112, 114, 116, 118, 115]

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Add Habit Title", text: $habitTitle)
                        TextField("Add emoji", text: $selectedEmoji)
                        TextField("Descriptions", text: $descriptions)
                    }

//                    Section(header: Text("Start Date")) {
//                        DatePicker("", selection: $startDate, displayedComponents: .date)
//                            .datePickerStyle(GraphicalDatePickerStyle())
//                    }
//
//                    Section(header: Text("Repeat")) {
//                        HStack {
//                            ForEach(0..<daysOfWeek.count) { index in
//                                Button(action: {
//                                    repeatDays[index].toggle()
//                                }) {
//                                    Text(daysOfWeek[index])
//                                        .foregroundColor(repeatDays[index] ? .white : .primary)
//                                        .frame(width: 30, height: 30)
//                                        .background(repeatDays[index] ? Color.red : Color.clear)
//                                        .cornerRadius(15)
//                                        .overlay(
//                                            Circle()
//                                                .stroke(Color.red, lineWidth: 1)
//                                        )
//                                }
//                            }
//                        }
//                    }
//
//                    Section {
//                        Toggle(isOn: $remindersEnabled) {
//                            Text("Reminders")
//                        }
//                    }
                }
            }
            .navigationBarTitle("Add Habit", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                // Dismiss action here
                self.showModal = false
            }), trailing: Button("Add", action: {
                // Add habit action here
                let habit = HabitModel(
                    title: habitTitle,
                    body: descriptions,
                    days: daysSet,
                    emoji: selectedEmoji
                )
                context.insert(habit)
                self.showModal = false

            }))
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
