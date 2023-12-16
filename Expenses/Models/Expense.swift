//
//  Expense.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import Foundation

import SwiftData

import OSLog


private let logger = Logger(subsystem: "Expenses", category: "Expense")


@Model
final class Expense {
    @Attribute(.unique)
    var id:UUID
    var name:String
    var desc:String
    var value:Double
    var createdAt:Date
    var updatedAt:Date
    var schedule: ExpenseSchedule
    
    var expensesGroup: ExpensesGroup?
    
    var categories:[ExpenseCategory] = []

    init(
        name: String,
        value: Double,
        desc: String = "",
        schedule: ExpenseSchedule,
        categories:[ExpenseCategory] = []
    ) {
        self.id = UUID()
        self.name = name
        self.desc = desc
        self.value = value
        self.createdAt = .now
        self.updatedAt = .now
        self.schedule = schedule
        self.categories = categories
    }

}

struct ExpenseSchedule: Codable {
    var start:Date
    var end:Date
    var frequency:DateFrequency
    
    static func createDefault() -> ExpenseSchedule {
        return ExpenseSchedule(start: .now, end: .now, frequency: .unique)
    }
}

enum DateFrequency: Codable {
    case unique
    case daily
    case weekly
    case monthly
    case yearly
}


extension Expense {
    
    
    static func generate(modelContext: ModelContext) {
        
        
        func createExpense(
            using modelContext:ModelContext,
            name:String,
            value:Double,
            date: Date
        ) -> Expense {
            
            let schedule = ExpenseSchedule(start: date, end: date, frequency: .unique)
            
            let newExpense = Expense(
                name: name,
                value: value,
                schedule: schedule
            )
            
            modelContext.insert(newExpense)
            
            return newExpense
        }
        
        func addCategories(
            using modelContext: ModelContext,
            expense:Expense,
            categories:[ExpenseCategory],
            categoryNames:[String]
        ) -> Expense
        {
            
            for name in categoryNames {
                let expenseCategory = categories.first(where: { $0.name == name })!
                logger.info("Adding category \(expenseCategory.name) to expense \(expense.name)")
                expense.categories.append(expenseCategory)
            }
            return expense
        }
        
        func addExpensesGroup(
            using modelContext: ModelContext,
            expense:Expense,
            expensesGroupName:ExpensesGroup
        )
        {
            expense.expensesGroup = expensesGroupName
            try! modelContext.save()
        }
        
        func createAndSaveExpense(
            using modelContext: ModelContext,
            name: String,
            value: Double,
            date: Date,
            categoryNames:[String],
            categories:[ExpenseCategory],
            expenseGroup:ExpensesGroup
        ) 
        {
            var expense = createExpense(
                using: modelContext,
                name: name,
                value: value,
                date: date
            )
            expense = addCategories(
                using: modelContext,
                expense: expense,
                categories: categories,
                categoryNames: categoryNames
            )
            expense.expensesGroup = defaultExpensesGroup
            
            try! modelContext.save()
        }
        
        let dayInSeconds = 24 * 60 * 60
  
        let calendar = Calendar.current
        
        let today = Date()
        
        let day = calendar.component(.day, from: today)
                
        let dateComponents = DateComponents(
            year: calendar.component(.year, from: today),
            month: calendar.component(.month, from: today),
            day: calendar.component(.day, from: today)
        )
        
        let startDate = calendar.date(from:dateComponents)!
        
        let categories = try! modelContext.fetch(FetchDescriptor<ExpenseCategory>())
        
        let expensesGroups = try! modelContext.fetch(FetchDescriptor<ExpensesGroup>())
        
        let defaultExpensesGroup = expensesGroups.first(where: { $0.name == "My Expenses" })!
        
        // add some daily expenses
        for day in stride(from: 1 , to:120, by:2) {
            createAndSaveExpense(
                using: modelContext,
                name: "Bus",
                value: -Double.random(in: 3...5),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Transport"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )
        }
        
        
        for day in stride(from: 0, to: 120, by: 2) {
    
            createAndSaveExpense(
                using: modelContext,
                name: "Supermarket",
                value: -Double.random(in: 20...30),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Food"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )

        }
        // add some weekly expenses
        for day in stride(from: 3, to: 120, by: 7) {
            createAndSaveExpense(
                using: modelContext,
                name: "Dinner",
                value: -Double.random(in: 30...50),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Food","Personal"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )
        }
        
        // add some weekly expenses
        for day in stride(from: 0, to: 120, by: 7) {
            createAndSaveExpense(
                using: modelContext,
                name: "Car",
                value: -Double.random(in: 30...50),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Transport","Personal"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )
        }
        
        for day in stride(from: day, to: 120, by: 30) {
            createAndSaveExpense(
                using: modelContext,
                name: "Gym",
                value: -Double.random(in: 40...60),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Personal"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )
        }

        
        // add some monthly expenses
        for day in stride(from: day, to: 120, by: 30) {
            createAndSaveExpense(
                using: modelContext,
                name: "Rent",
                value: -Double.random(in: 1500...2000),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Housing"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )
        }
        
        // add some monthly expenses
        for day in stride(from: day, to: 120, by: 30) {
            createAndSaveExpense(
                using: modelContext,
                name: "Salary",
                value: Double.random(in: 3300...4300),
                date: startDate - TimeInterval(dayInSeconds*day),
                categoryNames: ["Housing"],
                categories: categories,
                expenseGroup: defaultExpensesGroup
            )
        }

        createAndSaveExpense(
            using: modelContext,
            name: "Jeans",
            value: -Double.random(in: 30...50),
            date: startDate - TimeInterval(dayInSeconds*2),
            categoryNames: ["Clothing","Personal"],
            categories: categories,
            expenseGroup: defaultExpensesGroup
        )

        createAndSaveExpense(
            using: modelContext,
            name: "Shoes",
            value: -Double.random(in: 30...50),
            date: startDate - TimeInterval(dayInSeconds*1),
            categoryNames: ["Clothing","Personal"],
            categories: categories,
            expenseGroup: defaultExpensesGroup
        )
        
    }
}
