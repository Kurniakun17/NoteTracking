//
//  Deleting.swift
//  NotesHabit
//
//  Created by Natasha Hartanti Winata on 16/07/24.
//

import Foundation

protocol Deletable {
    associatedtype ItemType
    func delete(item: ItemType)
}
