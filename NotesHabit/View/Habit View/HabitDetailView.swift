//
//  HabitDetailView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 12/07/24.
//

import SwiftUI

struct HabitDetailView:View {
    let habit:HabitModel
    var body: some View {
        VStack {
            Text("Detail for \(habit.title)")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationBarTitle(habit.title, displayMode: .inline)
    }
}
//#Preview {
//    HabitDetailView()
//}
