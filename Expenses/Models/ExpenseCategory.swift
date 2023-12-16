//
//  ExpenseCategory.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import Foundation
import SwiftData

@Model
final class ExpenseCategory {
    @Attribute(.unique)
    var name:String
    
    var imageName:String
    
    init(name: String, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

extension ExpenseCategory {
    
    static func generate(modelContext: ModelContext) {
        
        for category in ExpenseCategoryIcon.allCases {
            let newExpenseCategory = ExpenseCategory(name:category.name(), imageName: category.rawValue)
            modelContext.insert(newExpenseCategory)
        }       
        try! modelContext.save()
    }
}


enum ExpenseCategoryIcon: String, Codable, CaseIterable {
    case housing = "house"
    case transport = "car"
    case food = "fork.knife"
    case clothing = "hanger"
    case healthcare = "cross.case"
    case insurance = "key"
    case education = "graduationcap"
    case personal = "dumbbell"
    case work = "wrench.and.screwdriver"
//    case debt = "briefcase"
    case entretainment = "play.rectangle"
    
    func name() -> String {
        switch self {
        case .housing: return "Housing"
        case .transport: return "Transport"
        case .food: return "Food"
        case .clothing: return "Clothing"
        case .healthcare: return "Healthcare"
        case .insurance: return "Insurance"
        case .education: return "Education"
        case .personal: return "Personal"
        case .work: return "Work"
//        case .debt: return "Bebt"
        case .entretainment: return "Entretainment"
        }
    }
}
