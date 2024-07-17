//
//  CardView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI
import SwiftData

struct CardHabitView: View {
    var habit: HabitModel
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 80, height: 80)
                .overlay(
                    Text(habit.emoji)
                        .font(.system(size: 40))
                )
            //                .padding(.horizontal, -5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(habit.folder?.title ?? String(localized: "No Folder"))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(habit.title)
                    .font(.headline)
                
                HStack {
                    HStack {
                        Image(systemName: "flame")
                        Text("\(habit.streak)")
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                        Text(timeString(from: habit.time))
                    }
                }
                .foregroundColor(.gray)
                .font(.system(size: 14))
            }
            
            Spacer()
        }
        .padding()
        .cornerRadius(10)
    }
    
    func timeString(from date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        if let date = date {
            return formatter.string(from: date)
        } else {
            return String(localized: "Add Reminder")
        }
    }
}

struct ContentView4: View {
    let goalsContent: [HabitModel] = [
        HabitModel(title: "Morning Routines", body: "Personal", days: [2, 4, 6], startDate: Date(), emoji: "🌅", notes: [], streak: 5, lastLog: Date()),
        HabitModel(title: "SwiftUI Learn", body: "Personal > Study", days: [1, 3, 5], startDate: Date(), emoji: "📚", notes: [], time: Date(), streak: 10, lastLog: Date()),
        HabitModel(title: "Learn Figma", body: "Personal > Study", days: [1, 3, 5], startDate: Date(), emoji: "🎨", notes: [], time: Date(), streak: 10, lastLog: Date())
    ]
    
    var body: some View {
        ScrollView {
            ForEach(goalsContent) { habit in
                CardHabitView(habit: habit)
                    .padding(.horizontal)
                    .padding(.top, 4)
            }
        }
    }
}


#Preview {
    do
    {
        var config = ModelConfiguration(isStoredInMemoryOnly: true)
        var container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        return ContentView4()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}
