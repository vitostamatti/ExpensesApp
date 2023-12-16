//
//  DataGeneration.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import SwiftData
import OSLog


private let logger = Logger(subsystem: "Expenses", category: "DataGeneration")


@Model
class DataGeneration {
    public var initializationDate: Date?
    
    
    public var requiresInitialDataGeneration: Bool {
        initializationDate == nil
    }
    
    init(initializationDate: Date? = nil) {
        self.initializationDate = initializationDate
    }
    
    private func generateInitial(modelContext: ModelContext) {
        logger.info("Generating initial data for ExpensesGroup")
        ExpensesGroup.generate(modelContext: modelContext)
        
        logger.info("Generating initial data for ExpenseCategory")
        ExpenseCategory.generate(modelContext: modelContext)
        
        logger.info("Generating initial data for UserProfile")
        UserProfile.generate(modelContext: modelContext)
        
//        logger.info("Generating initial data for UserSession")
//        UserSession.generate(modelContext: modelContext)
        
        logger.info("Generating initial data for Expenses")
        Expense.generate(modelContext: modelContext)
        
        logger.info("Completed generating initial data")
        initializationDate = .now
    }
    
    
    private static func instance(with modelContext: ModelContext) -> DataGeneration {
        if let result = try! modelContext.fetch(FetchDescriptor<DataGeneration>()).first {
            return result
        } else {
            let instance = DataGeneration(
                initializationDate: nil
            )
            modelContext.insert(instance)
            return instance
        }
    }
    
    public static func generateInitialData(modelContext: ModelContext) {
        let instance = instance(with: modelContext)
        logger.info("Attempting to generate initial data")
        instance.generateInitial(modelContext: modelContext)
        try! modelContext.save()
    }
    
}

extension DataGeneration {
    static let schema = Schema([
        DataGeneration.self,
//        UserSession.self,
        UserProfile.self,
        ExpensesGroup.self,
        ExpenseCategory.self,
        Expense.self
    ])
    static let container = try! ModelContainer(
        for: schema,
        configurations: [.init(isStoredInMemoryOnly: DataGenerationOptions.inMemoryPersistence)]
    )
}


class DataGenerationOptions {
    /// When true, do not save data to disk. When false, saves data to disk.
    public static let inMemoryPersistence = true
    
    public static let addPreviewInitialData = true
}
