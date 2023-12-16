//
//  ExpenseGroup.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import Foundation
import SwiftData

@Model
final class ExpensesGroup {
    
    @Attribute(.unique)
    var id:UUID
    
    var name:String
    var desc:String?
    var createdAt:Date
    var expenses:[Expense] = []
    
    init(name: String, desc: String? = nil) {
        self.id = UUID()
        self.name = name
        self.desc = desc
        self.createdAt = .now
    }
}


extension ExpensesGroup {
    static func generate(modelContext: ModelContext) {
        let expensesGroup = ExpensesGroup(
            name:"My Expenses",
            desc:"Centralized place to store and see all my expenses"
        )
        let expensesGroup2 = ExpensesGroup(
            name:"My Expenses 2",
            desc:"Centralized place to store and see all my expenses"
        )
        modelContext.insert(expensesGroup)
        modelContext.insert(expensesGroup2)
        try! modelContext.save()
    }
}
