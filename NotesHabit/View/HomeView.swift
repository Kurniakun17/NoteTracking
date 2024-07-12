//
//  HomeView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var showModal = false
    @Query(animation: .snappy) private var habits: [HabitModel]
    @Query(animation: .snappy) private var notes: [NoteModel]
    @Query(animation: .snappy) private var folders: [FolderModel]
    
    var body: some View {
            NavigationView {
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 5) {
                            SearchBar()
                            
                            Section(header: Text("Habits").font(.headline)) {
                                ForEach(habits) { habit in
                                    CardHomeView(habit: habit)
                                }
                            }
                            
                            Section(header: Text("Notes").font(.headline)) {
                                Text("Item 1")
                                Text("Item 2")
                                Text("Item 3")
                            }
                            
                            Spacer(minLength: 100) // Add some space at the bottom so the content doesn't overlap with the footer
                        }
                        .padding()
                    }
                    
                    VStack {
                        Spacer()
                        Footer()
                    }
                }
                .navigationTitle("Activity Hub")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            self.showModal = true
                        }) {
                            Image(systemName: "plus")
                        }
                )
                .sheet(isPresented: $showModal) {
                    // HomeModalView(showModal: self.$showModal)
                }
            }
        }
}

//struct HomeModalView: View {
//    // Binding to the state variable to dismiss the modal
//    @Binding var showModal: Bool
//    @Environment(\.modelContext) private var context
//    @State private var habitTitle: String = ""
//    @State private var emoji: String = ""
//    @State private var description: String = ""
//    @State private var reminderOn: Bool = false
//    @State private var showTimePicker: Bool = false
//    @State private var showDatePicker: Bool = false
//    @State private var selectedTime: Date = Date()
//    @State private var selectedDate: Date = Date()
//    @State private var selectedDays: Set<Int> = []
//
//    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
//    let fullDaysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Add Habit Title", text: $habitTitle)
//                    TextField("Add Description", text: $description)
//                }
//
//                Section {
//                    HStack {
//                        Text("Start Date")
//                        Spacer()
//                        Text("\(selectedDate, formatter: dateFormatter)")
//                            .foregroundColor(.gray)
//                    }
//                    .onTapGesture {
//                        showDatePicker.toggle()
//                    }
//
//                    if showDatePicker {
//                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
//                            .datePickerStyle(GraphicalDatePickerStyle())
//                    }
//
//                    HStack {
//                        Text("Repeat ")
//                        Spacer()
//                        Text(repeatDaysText())
//                            .foregroundColor(.gray)
//                    }
//
//                    HStack {
//                        ForEach(0..<7) { index in
//                            Button(action: {
//                                toggleDaySelection(index)
//                            }) {
//                                Text(daysOfWeek[index])
//                                    .frame(width: 30, height: 30)
//                                    .background(selectedDays.contains(index) ? Color.red : Color.clear)
//                                    .foregroundColor(selectedDays.contains(index) ? .white : .primary)
//                                    .clipShape(Circle())
//                                    .overlay(
//                                        Circle().stroke(Color.red, lineWidth: selectedDays.contains(index) ? 0 : 1)
//                                    )
//                                    .padding(.vertical, 4)
//                            }
//                        }
//                    }
//                }
//
//                Section {
//                    Toggle("Reminder", isOn: $reminderOn)
//                        .onChange(of: reminderOn) { value in
//                            showTimePicker = value
//                        }
//
//                    if showTimePicker {
//                        HStack {
//                            Text("Time")
//                            Spacer()
//                            Text("\(selectedTime, formatter: timeFormatter)")
//                                .foregroundColor(.gray)
//                        }
//                        .onTapGesture {
//                            showTimePicker.toggle()
//                        }
//
//                        if showTimePicker {
//                            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
//                                .datePickerStyle(WheelDatePickerStyle())
//                                .labelsHidden()
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Add Habit", displayMode: .inline)
//            .navigationBarItems(leading: Button("Cancel", action: {
//                // action for cancel
//                self.showModal = false
//            }),
//            trailing: Button("Done", action: {
//                // action for done
////                let habit = HabitModel(title: <#T##String#>, body: <#T##String#>, days: <#T##Set<Int>#>, emoji: "")
////                context.insert(habit)
//                
//                
//            }))
//        }
//        .accentColor(.red)
//    }
//
//    private var timeFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        return formatter
//    }
//
//    private var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter
//    }
//
//    private func repeatDaysText() -> String {
//        let sortedDays = selectedDays.sorted()
//        switch sortedDays {
//        case [1, 2, 3, 4, 5]:
//            return "Every Weekday"
//        case [0, 6]:
//            return "Every Weekend"
//        case [0, 1, 2, 3, 4, 5, 6]:
//            return "Everyday"
//        default:
//            let days = sortedDays.map { fullDaysOfWeek[$0] }
//            return days.isEmpty ? "None" : days.joined(separator: ", ")
//        }
//    }
//
//    private func toggleDaySelection(_ index: Int) {
//        if selectedDays.contains(index) {
//            selectedDays.remove(index)
//        } else {
//            selectedDays.insert(index)
//        }
//    }
//
//}

#Preview {
    HomeView()
}
