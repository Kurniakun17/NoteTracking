//
//  Searchable.swift
//  NotesHabit
//
//  Created by Ahmad Syafiq Kamil on 16/07/24.
//

import Foundation

protocol Searchable{
    associatedtype ItemType
    func search(item: [ItemType])
}
