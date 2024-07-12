//
//  CardHomeView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 12/07/24.
//

import SwiftUI


//struct Habit: Identifiable {
//    var id = UUID()
//    var title: String
//    var count: Int
//}


struct CardHomeView: View {
    //    let habits = [
    //        Habit(title: "All Habits", count: 3),
    //        Habit(title: "Study SwiftUI", count: 1),
    //        Habit(title: "Workout", count: 2)
    //    ]
    
    let habit: HabitModel
    
    var body: some View {
        //        NavigationView {
        NavigationLink(destination: HabitDetailView(habit: habit)) {
            HStack {
                Image(systemName: "folder")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(habit.title)
                Spacer()
                Text("\(habit.notes.count)")
                    .foregroundColor(.gray)
            }
        }
    }
}

//#Preview {
//    CardHomeView()
//}



