//
//  GoalsView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI
import SwiftData

struct HabitsView: View {
    @State private var showModal = false
    @Query(animation: .snappy) private var habits: [HabitModel]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 5) {
                    SearchBar()
                    ForEach(habits){habit in
                        GoalCard(goal: habit)
                    }
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Habits")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showModal = true
                    }) {
                        Image(systemName: "plus")
                    })
            .sheet(isPresented: $showModal) {
                
                ModalView(showModal: self.$showModal)
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
    var daysSet : Set = [112, 114, 116, 118, 115]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Add Habit Title", text: $habitTitle)
                        TextField("Add emoji", text: $selectedEmoji)
                        TextField("Descriptions", text: $descriptions)
                    }
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
                    emoji: selectedEmoji)
                context.insert(habit)
                self.showModal = false
                
            }))
        }
    }
}


#Preview {
    HabitsView()
}



