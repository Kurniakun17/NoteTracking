//
//  ScheduledHabitListItem.swift
//  NotesHabit
//
//  Created by Natasha Hartanti Winata on 16/07/24.
//

import SwiftUI

struct ScheduledHabitListItem: View {
    let habit: HabitModel
    let isComplete: Bool

    var body: some View {
        NavigationLink(destination: HabitDetail(habit: habit)) {
            HStack(spacing: 12) {
                Image(systemName: "book.and.wrench")

                Text(habit.title)
                Spacer()

                if isComplete {
                    HStack(spacing: 8) {
                        Text(String(habit.streak))
                            .foregroundColor(habit.streak == 0 ? .gray : .orangeStreak)
                        Image(systemName: "flame.fill")
                            .foregroundStyle(habit.streak == 0 ? .gray : .orangeStreak)
                    }
                } else {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.primaryRed)
                }
            }
        }
        .padding(.horizontal, -10)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                // Add delete action here
                habit.deleteAt = Date()
            } label: {
                Image(systemName: "trash.fill")
            }
        }
    }
}
