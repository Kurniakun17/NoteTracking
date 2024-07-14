//
//  FolderRow.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 14/07/24.
//

import SwiftUI

struct FolderRow<Destination: View>: View {
    var destination: Destination
    var title: String
    var count: Int
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: "folder")
                Text(title)
                Spacer()
                Text("\(count)")
                    .foregroundColor(.gray)
            }
        }
    }
}

//#Preview {
//    FolderRow()
//}
