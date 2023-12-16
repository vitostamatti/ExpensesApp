//
//  ExpensesListItemView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI
import SwiftData

struct ExpensesListItemView:View {
    let expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.schedule.start, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}


#Preview {
    ModelPreview { expense in
        ExpensesListItemView(expense: expense)
    }
}
