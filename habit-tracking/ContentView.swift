//
//  ContentView.swift
//  habit-tracking
//
//  Created by Denis Evdokimov on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits: Habits = Habits()
    @State var addnewHabit: Bool = false
    var body: some View {
        NavigationStack {
            List{
                ForEach(habits.items) { item in
                    NavigationLink(value: item) {
                        Text(item.name) // как отображаем строку в списке
                        Text("количество \(item.amount)")
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Habits")
            .navigationDestination(for: Habit.self) { habit in
                DetaledHabitView(habit1: habit, habits: habits) //экран куда перейдем при тапе на строку
            }
            .padding()
            .toolbar {
                Button("Add") {
                    addnewHabit = true
                }
            }
        }
        .sheet(isPresented: $addnewHabit) {
            AddNewHabitView(habits: habits)
        }
       
    }
        
    
    func delete(at offsets: IndexSet){
        habits.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView(habits: .init())
}

struct AddNewHabitView: View {
    var habits: Habits
    @State var nameHabite: String = ""
    @State var descriptionHabit: String = ""
    @State var count: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
       
        VStack {
            Form {
                Text("Название новой привычки")
              
                TextField("новая привычка", text: $nameHabite)
            }
            Form {
                Text("Описание новой  привычки")
                TextField("новая привычка", text: $descriptionHabit, axis: .vertical)
                .lineLimit(4)
                
            }
       
                VStack {
                    Button("+1 ") {
                        count += 1
                    }
                    Button("сохранить и выйти") {
                        saveNewHabit()
                        dismiss()
                    }
                }
                .padding()
            
            
        }
    }
    private func saveNewHabit(){
//        let new = Habit(name: nameHabite, description: descriptionHabit, amount: count)
//        print(count)
//        habits.items.insert(new, at: 0)
    }
}

struct DetaledHabitView: View {
    
    var habits: Habits
    var habit: Habit
   
   @State var amount: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    init(habit1: Habit, habits: Habits) {
        let temp = habit1
        let temp2 = habits
        habit = habit1
        self.habits = temp2

    }
    
    var body: some View {
       
        VStack {
            Form {
                Text(habit.name)
               
            }
            Form {
                Text(habit.description)
               
            }
            
                HStack {
                    VStack {
                        Text("Текущий повтор \(amount)")
                        
                        Button("+1 ") {
                            addCount()
                        }
                    }
                    Spacer()
                   
                    Button(action: {
                        saveHabit()
                        dismiss()
                    }, label: {
                        Image(systemName: "gear")
                        Text("Save and Exit")
                    })
               
                }
                .onAppear(perform: {
                    amount = habit.amount
                })
            }
        .padding()
            
        
    }
        
    private func addCount() {
      amount += 1
    }
    
    
    private func saveHabit(){
       
        let indx =  habits.items.firstIndex(of: habit)
  
        if let indx = indx {
       
            let newhabit = Habit(name: habit.name, description: habit.description, amount: amount)
            habits.items[indx] = newhabit
          
        }
       
        
        
    }
}
