//
//  ExpensesGroupsListView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI
import SwiftData

struct ExpensesGroupsListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort:\ExpensesGroup.createdAt) var expensesGroups: [ExpensesGroup]
    
    var body: some View {
        
        ScrollView {
            ForEach(expensesGroups) {expensesGroup in
                ExpensesGroupsListItemView(
                    expensesGroup: expensesGroup
                )
            }
            .padding()
        }
        
        
        Spacer()
        
        NavigationLink {
            CreateExpensesGroupView()
        } label: {
            VStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            
        }
    }
    
}

#Preview {
    ExpensesGroupsListView()
        .appDataContainer(inMemory: true)
}
