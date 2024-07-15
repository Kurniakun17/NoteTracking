//
//  HabitFolderViewModel.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 15/07/24.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var habits: [HabitModel]

    private let dataSource: SwiftDataService

    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        self.habits = dataSource.fetchHabits()
    }

    func addHabit(habit: HabitModel) {
        dataSource.addHabit(habit: habit)
        habits = dataSource.fetchHabits()
    }

    func deleteHabit(habit: HabitModel) {
        dataSource.deleteHabit(habit: habit)
        habits = dataSource.fetchHabits()
    }

    func updateHabitLastLog(habit: HabitModel) {
        if let habitLogged = habit.lastLog {
            if !Calendar.current.isDateInToday(habitLogged) {
                habit.streak += 1
            }
        } else {
            habit.streak += 1
        }
        habit.lastLog = Date()
    }
}
