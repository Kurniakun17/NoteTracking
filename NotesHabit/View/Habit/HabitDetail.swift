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
        0: String(localized: "Sun"),
        1: String(localized: "Mon"),
        2: String(localized: "Tue"),
        3: String(localized: "Wed"),
        4: String(localized: "Thu"),
        5: String(localized: "Fri"),
        6: String(localized: "Sat")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            
                        Text(String(habit.streak))
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.orangeStreak)
                    
                    formattedText()
                }
                Text("Add new or edit a new note to keep streak!")
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
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
    
    func formattedText() -> some View {
        if let time = habit.time?.toTimeString() {
            Text("Repeat on ") +
            Text(time).fontWeight(.semibold) +
            Text(" \(repeatDaysText(days: habit.days))")
        } else {
            Text("Repeat \(repeatDaysText(days: habit.days))")
        }
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
