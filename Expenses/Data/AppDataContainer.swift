//
//  DataContainer.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import SwiftUI
import SwiftData



struct AppDataContainerViewModifier: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        container = try! ModelContainer(
            for: DataGeneration.schema,
            configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)]
        )
    }
    func body(content: Content) -> some View {
        content
            .generateInitialData()
            .modelContainer(container)
    }
}


struct GenerateDataViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        content.onAppear {
            DataGeneration.generateInitialData(modelContext: modelContext)
        }
    }
}


extension View {
    func appDataContainer(inMemory: Bool = DataGenerationOptions.inMemoryPersistence) -> some View {
        modifier(AppDataContainerViewModifier(inMemory: inMemory))
    }
}


fileprivate extension View {
    func generateInitialData() -> some View {
        modifier(GenerateDataViewModifier())
    }
}

