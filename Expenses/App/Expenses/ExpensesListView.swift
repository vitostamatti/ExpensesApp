//
//  ExpensesListView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI
import SwiftData

struct ExpensesListView: View {
    @State var searchText = ""
    
    var body: some View {
        
        List {
            ExpensesListSearchResult(searchText: $searchText)
        }
        .searchable(text: $searchText)
    }
}

struct ExpensesListSearchResult:View {
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses:[Expense]
    
    @Binding var searchText:String
    
    init(searchText: Binding<String>) {
        _searchText = searchText
        if searchText.wrappedValue.isEmpty {
            _expenses = Query(sort:\Expense.schedule.start, order: .reverse)
        } else {
            let term = searchText.wrappedValue
            _expenses = Query(filter: #Predicate { expense in
                expense.name.contains(term)
            }, sort:\Expense.schedule.start, order: .reverse)
        }
    }
    
    var body: some View {
        ForEach(expenses) {expense in
            NavigationLink {
                ExpensesDetailView(expense: expense)
            } label: {
                ExpensesListItemView(expense:expense)
            }
            
        }
        .onDelete(perform: { indexSet in
            for index in indexSet {
                modelContext.delete(expenses[index])
            }
        })
        
    }
}

#Preview {
    NavigationStack {
        ExpensesListView()
            .appDataContainer(inMemory: true)
    }
}
