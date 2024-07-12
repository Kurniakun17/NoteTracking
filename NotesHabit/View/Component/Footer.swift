//
//  Footer.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 12/07/24.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        HStack {
            Menu {
                Button(action: {
                    // Action for option 1
                    print("Option 1 selected")
                }) {
                    Text("Option 1")
                }
                Button(action: {
                    // Action for option 2
                    print("Option 2 selected")
                }) {
                    Text("Option 2")
                }
                Button(action: {
                    // Action for option 3
                    print("Option 3 selected")
                }) {
                    Text("Option 3")
                }
            } label: {
                Image(systemName: "folder.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.brown)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Button(action: {
                // Action for the right button
                print("Right button tapped")
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.brown)
            }
            .padding(.trailing, 20)
        }
        .padding()
    }
}


#Preview {
    Footer()
        .previewLayout(.sizeThatFits)
}
