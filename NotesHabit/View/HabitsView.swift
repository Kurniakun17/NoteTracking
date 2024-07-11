//
//  GoalsView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI

struct HabitsView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                SearchBar()
                ScrollView(.horizontal){
                    
                }
            }
            .padding()
            .navigationTitle("Habits")
            .navigationBarItems(trailing:
                                    Button(action: {
                // Action for the button
            }) {
                Image(systemName: "plus")
            }
            )
        }
    }
}

#Preview {
    HabitsView()
}
