//
//  Adding.swift
//  NotesHabit
//
//  Created by Natasha Hartanti Winata on 16/07/24.
//

import Foundation

protocol Addable {
    associatedtype ItemType
    func add(item: ItemType)
}
