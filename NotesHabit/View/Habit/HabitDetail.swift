//
//  HabitDetail.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 14/07/24.
//

import SwiftData
import SwiftUI

struct HabitDetail: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    @EnvironmentObject var habitViewModel: HabitViewModel
    @State private var searchText: String = ""
    var habit: HabitModel
    var formatter: Formatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"

        return formatter
    }

    @Environment(\.colorScheme) var colorScheme

    let dayNames: [Int: String] = [
        0: "Sun",
        1: "Mon",
        2: "Tue",
        3: "Wed",
        4: "Thu",
        5: "Fri",
        6: "Sat"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(.yellow)
                        Text(String(habit.streak))
                            .fontWeight(.bold)
                    }

                    Text(formattedString())
                }
                Text("Add new or edit a new note to keep streak!")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .background(colorScheme == .dark ? .black : .white)

            NotesList(filteredNotes: filteredNotes)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(habit.title)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Spacer()

                    NavigationLink(
                        destination: AddNoteView(habit: habit)
                    ) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }

    func formattedString() -> String {
        var result = "Repeat "
        if let time = habit.time?.toTimeString() {
            result += "on **\(time)** "
        }
        result += repeatDaysText(days: habit.days)
        return result
    }

    func repeatDaysText(days: Set<Int>) -> String {
        switch days {
        case [1, 2, 3, 4, 5]:
            return String(localized: "Every Weekday")
        case [0, 6]:
            return String(localized: "Every Weekend")
        case [0, 1, 2, 3, 4, 5, 6]:
            return String(localized: "Everyday")
        default:
            let days = days.compactMap { dayNames[$0] }
            return days.isEmpty ? String(localized: "None") : String(localized: "Every ") + days.joined(separator: ", ")
        }
    }
    
    var filteredNotes: [NoteModel] {
        if searchText.isEmpty {
            return habit.notes
        } else {
            return habit.notes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
