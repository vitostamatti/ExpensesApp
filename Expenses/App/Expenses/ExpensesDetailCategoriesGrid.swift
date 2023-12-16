//
//  ExpensesDetailCategoriesGrid.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI


struct ExpensesDetailCategoriesGrid: View {
    
    let expense:Expense
    
    let columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .center) {
            ForEach(expense.categories) {category in
                VStack{
                    Image(systemName: category.imageName)
                        .imageScale(.large)
                    Text(category.name)
                        .fontWeight(.semibold)
                }
                .padding(6)
            }
        }
    }
}

#Preview {
    ModelPreview { expense in
        ExpensesDetailCategoriesGrid(expense:expense)
    }
    
}
