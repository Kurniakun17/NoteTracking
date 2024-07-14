////
////  GoalsView.swift
////  NotesHabit
////
////  Created by Ahmad Syafiq Kamil on 11/07/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct HabitsView: View {
//    @State private var showModal = false
//    @Query(animation: .snappy) private var habits: [HabitModel]
//    
//    var body: some View {
//        NavigationView {
//            ScrollView{
//                VStack(alignment: .leading, spacing: 5) {
//                    SearchBar()
//                    ForEach(habits){habit in
//                        Text(habit.title)
//                        Text(habit.emoji)
//                        Text(habit.body)
//                    }
//                    Spacer()
//                }
//            }
//            .padding()
//            .navigationTitle("Habits")
//            .navigationBarItems(
//                trailing:
//                    Button(action: {
//                        self.showModal = true
//                    }) {
//                        Image(systemName: "plus")
//                    })
//            .sheet(isPresented: $showModal) {
//                
//                ModalView(showModal: self.$showModal)
//            }
//        }
//    }
//}
//
////var id = UUID()
////var title: String
////var body: String
////var days: Set<Int>
////var startDate = Date()
////var folder: FolderModel?
////var emoji: String
//
//
//struct ModalView: View {
//    // Binding to the state variable to dismiss the modal
//    @Binding var showModal: Bool
//    @State private var habitTitle = ""
//    @State private var selectedEmoji = ""
//    @State private var descriptions = ""
//    @State private var startDate = Date()
//    @State private var repeatDays: [Bool] = Array(repeating: false, count: 7)
//    @State private var remindersEnabled = false
//    @Environment(\.modelContext) private var context
//    
//    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
//    var daysSet : Set = [112, 114, 116, 118, 115]
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form {
//                    Section {
//                        TextField("Add Habit Title", text: $habitTitle)
//                        TextField("Add emoji", text: $selectedEmoji)
//                        TextField("Descriptions", text: $descriptions)
//                    }
//                    
////                    Section(header: Text("Start Date")) {
////                        DatePicker("", selection: $startDate, displayedComponents: .date)
////                            .datePickerStyle(GraphicalDatePickerStyle())
////                    }
////                    
////                    Section(header: Text("Repeat")) {
////                        HStack {
////                            ForEach(0..<daysOfWeek.count) { index in
////                                Button(action: {
////                                    repeatDays[index].toggle()
////                                }) {
////                                    Text(daysOfWeek[index])
////                                        .foregroundColor(repeatDays[index] ? .white : .primary)
////                                        .frame(width: 30, height: 30)
////                                        .background(repeatDays[index] ? Color.red : Color.clear)
////                                        .cornerRadius(15)
////                                        .overlay(
////                                            Circle()
////                                                .stroke(Color.red, lineWidth: 1)
////                                        )
////                                }
////                            }
////                        }
////                    }
////                    
////                    Section {
////                        Toggle(isOn: $remindersEnabled) {
////                            Text("Reminders")
////                        }
////                    }
//                }
//            }
//            .navigationBarTitle("Add Habit", displayMode: .inline)
//            .navigationBarItems(leading: Button("Cancel", action: {
//                // Dismiss action here
//                self.showModal = false
//            }), trailing: Button("Add", action: {
//                // Add habit action here
//                let habit = HabitModel(
//                    title: habitTitle,
//                    body: descriptions,
//                    days: daysSet,
//                    emoji: selectedEmoji)
//                context.insert(habit)
//                self.showModal = false
//                
//            }))
//        }
//    }
//}
//
//
//#Preview {
//    HabitsView()
//}
//
//
//
