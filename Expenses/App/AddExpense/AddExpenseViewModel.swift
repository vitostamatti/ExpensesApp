//
//  AddExpenseViewModel.swift
//  Expenses
//
//  Created by Vito Stamatti on 8/12/23.
//

import Foundation

class NewExpenseViewModel:ObservableObject {
    
    @Published var name:String = ""
    @Published var desc:String = ""
    @Published var date:Date = .now
    @Published var value:Double = 0
    @Published var selectedCategories:[ExpenseCategory] = []
    
    var formIsValid: Bool {
        (!name.isEmpty) || (value != 0)
    }
    
    func reset() {
        name = ""
        desc = ""
        date = .now
        value = 0
        selectedCategories = []
    }
    
    func isValid() -> Bool {
        true
    }
    
    func expense() -> Expense {
        let schedule = ExpenseSchedule(
            start: date,
            end: date,
            frequency: .unique
        )
        let expense = Expense(
            name: name,
            value: value,
            desc: desc,
            schedule: schedule,
            categories: selectedCategories
        )
        
        return expense
    }
}
