//
//  SearchView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                SearchBar()
                Spacer()
            }
            .padding()
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
