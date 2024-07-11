//
//  ContentView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Home")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            HabitsView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Habits")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "gear.circle")
                    Text("Setting")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
