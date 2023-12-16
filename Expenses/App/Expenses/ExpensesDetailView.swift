//
//  ExpensesDetailView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI

struct ExpensesDetailView:View {
    let expense: Expense
    
    var body: some View {
        
        VStack(spacing:18){
            
            HStack{
                Spacer()
                VStack(spacing:16){
                    Text(expense.name)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.accent)
                    
                    if expense.desc != "" {
                        Text(expense.desc)
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                    }
                        
                    
                    Divider()
                    Text(expense.value, format: .currency(code: "USD"))
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text(expense.schedule.start, format:.dateTime.year(.defaultDigits).month(.wide).day()
                    )
                    .font(.title2)
                    
                    ExpensesDetailCategoriesGrid(expense:expense)
                    
                    Divider()
                }
                Spacer()
                
            }

            

            NavigationLink {
                ExpensesEditView(expense: expense)
            } label: {
                Text("Edit")
                    .frame(width: 60)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
            }
        }
        .card()
        .padding()
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ModelPreview{ expense in
        NavigationStack{
            ExpensesDetailView(expense: expense)
        }
    }
}


