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
    var habit = HabitModel(title: "Swift UI", body: "asdasd", days: [1, 2, 3], emoji: "asdad", time: Date())
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

    var days: [String] {
        habit.days.compactMap { dayNames[$0] }
    }

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

                    HStack(spacing: 4) {
                        Text("Repeat")
                        if habit.time != nil {
                            Text("on")
                            Text(habit.time!.toTimeString())
                                .fontWeight(.bold)
                        }
                        Text("every")
                        Text(days.joined(separator: ", "))
                            .fontWeight(.bold)
                    }
//                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .background(colorScheme == .dark ? .black : .white)

            NotesList(filteredNotes: habit.notes)
        }
        .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
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
}

#Preview {
    do {
        @StateObject var noteViewModel = NoteViewModel(dataSource: .shared)
        @StateObject var folderViewModel = FolderViewModel(datasource: .shared)
        @StateObject var habitViewModel = HabitViewModel(dataSource: .shared)

        return HabitDetail()
            .environmentObject(noteViewModel)
            .environmentObject(folderViewModel)
            .environmentObject(habitViewModel)

    } catch {
        fatalError("Error")
    }
}
