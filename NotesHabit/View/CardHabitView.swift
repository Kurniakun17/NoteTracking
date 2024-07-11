//
//  CardView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI

struct CardHabitView: View {
    var habit: HabitModel
        var body: some View {
            HStack {
                Image(systemName: habit.emoji)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(habit.title)
                        .font(.headline)
                    
                    HStack {
                        Text("🔥 \(habit.streak)")
                        Text("📅 \(habit.notes.count)")
                    }
                    
//                    HStack {
//                        ForEach(habit., id: \.self) { day in
//                            Text(day)
//                                .frame(width: 20, height: 20)
//                                .background(Color(.systemGray4))
//                                .cornerRadius(10)
//                        }
//                    }
                }
                .padding(.vertical)
                
                Spacer()
            }
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 5)
        }
}

//#Preview {
//    CardHabitView()
//}
