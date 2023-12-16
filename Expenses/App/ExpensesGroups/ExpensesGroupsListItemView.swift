//
//  ExpensesGroupsListItemView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI

struct ExpensesGroupsListItemView: View {
    @Environment(\.dismiss) var dismiss
    
    let expensesGroup: ExpensesGroup
    
    var totalExpenses:Int {
        expensesGroup.expenses.count
    }
    
    var body: some View {
        Button {
//            userSession.expensesGroup = expensesGroup
            dismiss()
        } label: {
            VStack{
                HStack {
                    Text(expensesGroup.createdAt, format: .dateTime.month(.abbreviated).day())
                        .frame(width: 70, alignment: .leading)
                    Text(expensesGroup.name)
                    Spacer()
                    Text("\(totalExpenses)")
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }

        }
    }
}
