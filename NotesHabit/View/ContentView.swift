//
//  ContentView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        FoldersView()
    }
    
}
#Preview {
    do
    {
        var config = ModelConfiguration(isStoredInMemoryOnly: true)
        var container = try ModelContainer(for: HabitModel.self, configurations: config)
        
        return ContentView()
            .modelContainer(container)
        
    } catch {
        fatalError("Error")
    }
}
