//
//  Habit.swift
//  habit-tracking
//
//  Created by Denis Evdokimov on 6/18/24.
//

import Foundation

struct Habit: Identifiable, Equatable, Codable,Hashable {
    let id: UUID
    let name: String
    let description: String
    var amount: Int
    
    init(name: String, description: String, amount: Int) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.amount = amount
    }
}
