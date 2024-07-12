//
//  GoalsView.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 11/07/24.
//

import SwiftUI

struct HabitsView: View {
    @State private var showModal = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 5) {
                    SearchBar()
                    
                    
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Habits")
            .navigationBarItems(
                trailing:
                Button(action: {
                    self.showModal = true
                }) {
                    Image(systemName: "plus")
                })
            .sheet(isPresented: $showModal) {
                
                ModalView(showModal: self.$showModal)
            }
        }
    }
}

struct ModalView: View {
    // Binding to the state variable to dismiss the modal
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("This is the modal view")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                self.showModal = false
            }) {
                Text("Dismiss")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}



#Preview {
    HabitsView()
}


//ScrollView(.horizontal){
//    //section favorite
//    VStack(alignment: .leading) {
//        Text("Favorites")
//            .font(.headline)
//            .padding(.leading)
//        //Card 1
//        HStack {
//            Image(systemName: "🍟")
//                .resizable()
//                .frame(width: 40, height: 40)
//                .padding()
//
//            VStack(alignment: .leading) {
//                Text("tes habit")
//                    .font(.headline)
//
//                HStack {
//                    Text("🔥 10 hari")
//                    Text("📅 10 ")
//                }
//
//                HStack {
//                    Text("S")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//                    Text("S")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//                    Text("R")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//                    Text("K")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//
//                }
//            }
//            .padding(.vertical)
//        }
//        .background(Color(.systemGray5))
//        .cornerRadius(10)
//        .padding(.horizontal)
//
//        //Card 2
//        HStack {
//            Image(systemName: "🍟")
//                .resizable()
//                .frame(width: 40, height: 40)
//                .padding()
//
//            VStack(alignment: .leading) {
//                Text("tes habit")
//                    .font(.headline)
//
//                HStack {
//                    Text("🔥 10 hari")
//                    Text("📅 10 ")
//                }
//
//                HStack {
//                    Text("S")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//                    Text("S")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//                    Text("R")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//                    Text("K")
//                        .frame(width: 20, height: 20)
//                        .background(Color(.systemGray4))
//                        .cornerRadius(10)
//
//                }
//            }
//            .padding(.vertical)
//        }
//        .background(Color(.systemGray5))
//        .cornerRadius(10)
//        .padding(.horizontal)
//
//
//    }
//    .padding()
//}
//
////section all Habit
//VStack(alignment: .leading) {
//    Text("All Habit")
//        .font(.headline)
//        .padding(.leading)
//    //Card 1
//    HStack {
//        Image(systemName: "🍟")
//            .resizable()
//            .frame(width: 40, height: 40)
//            .padding()
//
//        VStack(alignment: .leading) {
//            Text("tes habit")
//                .font(.headline)
//
//            HStack {
//                Text("🔥 10 hari")
//                Text("📅 10 ")
//            }
//
//            HStack {
//                Text("S")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//                Text("S")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//                Text("R")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//                Text("K")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//
//            }
//        }
//        .padding(.vertical)
//    }
//    .background(Color(.systemGray5))
//    .cornerRadius(10)
//    .padding(.horizontal)
//
//    //Card 2
//    HStack {
//        Image(systemName: "🍟")
//            .resizable()
//            .frame(width: 40, height: 40)
//            .padding()
//
//        VStack(alignment: .leading) {
//            Text("tes habit")
//                .font(.headline)
//
//            HStack {
//                Text("🔥 10 hari")
//                Text("📅 10 ")
//            }
//
//            HStack {
//                Text("S")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//                Text("S")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//                Text("R")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//                Text("K")
//                    .frame(width: 20, height: 20)
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10)
//
//            }
//        }
//        .padding(.vertical)
//    }
//    .background(Color(.systemGray5))
//    .cornerRadius(10)
//    .padding(.horizontal)
//
//
//}
//.padding()
