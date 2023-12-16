//
//  ExpensesGroupView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI

struct ExpensesGroupsView: View {
    
    var body: some View {
        ExpensesGroupsListView()
            .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ExpensesGroupsView()
        .appDataContainer(inMemory: true)
}
