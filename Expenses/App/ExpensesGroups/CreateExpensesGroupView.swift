//
//  CreateExpensesGroupView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI

struct CreateExpensesGroupView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name:String = ""
    
    var body: some View {
        Form {
            TextField("Expenses Group Name", text: $name)
        }
        .navigationTitle("New Expenses Group")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement:.topBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItemGroup(placement:.topBarTrailing) {
                Button("Save") {
                    let expenseGroup = ExpensesGroup(name:name)
                    modelContext.insert(expenseGroup)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        CreateExpensesGroupView()
            .appDataContainer(inMemory: true)
    }
}
