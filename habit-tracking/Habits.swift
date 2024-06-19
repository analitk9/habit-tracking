//
//  Habits.swift
//  habit-tracking
//
//  Created by Denis Evdokimov on 6/18/24.
//

import Foundation


class Habits:  ObservableObject {
   @Published var items: [Habit] = .init() 
    {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults().setValue(encoded, forKey: "items")
            }
        }
    }
    
    init()  {
        if let data = UserDefaults().data(forKey: "items"),
        let items =  try? JSONDecoder().decode([Habit].self, from: data) {
            self.items = items
            return
        }
    }
 
}
