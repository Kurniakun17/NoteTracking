//
//  Menu.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 13/07/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        Menu("Options") {
            Button("Order Now", action: placeOrder)
            Button("Adjust Order", action: adjustOrder)
            Button("Cancel", action: cancelOrder)
        }
    }

    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }
}

#Preview {
    MenuView()
}
