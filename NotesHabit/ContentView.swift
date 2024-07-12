//
//  ContentView.swift
//  NotesHabit
//
//  Created by Kurnia Kharisma Agung Samiadjie on 10/07/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    @State var showOptions = false
    @Environment(\.modelContext) var context
    @Query var notes: [NoteModel]
    @State var isNewNote = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Habit")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1 ... 7, id: \.self) {
                                _ in
                                VStack {
                                    Text("Learn Swift UI 30 Minutes")
                                        .fontWeight(.semibold)
                                        .font(.callout)
                                    Divider()
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("90%")
                                                .font(.title2)
                                            Text("Consistency rate")
                                                .font(.caption)
                                        }
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text("20")
                                                .font(.title2)
                                            Text("Day Streak")
                                                .font(.caption)
                                        }
                                    }
                                }
                                .frame(maxWidth: 200)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    
                    NavigationLink(destination: AddNoteView(), isActive: $isNewNote) {
                        Text("Add New Notes")
                    }.scaleEffect(0)
                }
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("Recent notes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    List {
                        ForEach(notes, id: \.self) {
                            note in
                            NavigationLink(destination: EditNoteView(note: note, title: note.title, bodyText: note.body)) {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Image(systemName: "folder")
                                            .font(.callout)
                                        Text("Notes")
                                            .font(.callout)
                                    }
                                    Text(note.title)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    HStack(spacing: 12) {
                                        Text("11.08")
                                            .fontWeight(.semibold)
                                            .font(.caption)
                                        Text(note.body)
                                            .font(.caption)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button(action: {}) {
                                    Image(systemName: "heart")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(action: {}) {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .transition(AnyTransition.scale)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .navigationTitle("All Notes")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showOptions.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                        .confirmationDialog("Create new", isPresented: $showOptions) {
                            Button(action: {
                                context.insert(NoteModel(title: "", body: ""))
                                isNewNote = true
                                
                            }) {
                                Text("Add New Notes")
                            }
                        }
                    }
                }
                
                Spacer()
            }
            
            .searchable(text: $searchText)
            //        NewNoteView()
        }
    }
}
    
#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NoteModel.self, configurations: config)
        
        container.mainContext.insert(NoteModel(title: "title", body: "Body"))
            
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Content View Preview error")
    }
}
