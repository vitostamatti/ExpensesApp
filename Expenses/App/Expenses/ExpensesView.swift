//
//  ExpensesNavigationStack.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI

struct ExpensesView: View {
    
    var body: some View {
        NavigationStack {
            ExpensesListView()
                .toolbar{
                    ToolbarItemGroup(placement:.topBarLeading) {
                        ExpensesTopMenuView()
                    }
                }
        }
        
    }
}



#Preview {
    ExpensesView()
        .appDataContainer(inMemory: true)
}
