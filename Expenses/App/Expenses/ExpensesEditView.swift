//
//  ExpensesEditView.swift
//  Expenses
//
//  Created by Vito Stamatti on 6/12/23.
//

import SwiftUI
import SwiftData

struct ExpensesEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var expense: Expense
    
    @Query var categories: [ExpenseCategory]
    
    var body: some View {
        ScrollView{
            Text("Edit Expense")
                .font(.title)
                .foregroundStyle(.accent)
            
            // Value
            VStack(alignment:.center){
                TextField(
                    "Value",
                    value: $expense.value,
                    format:.currency(code: "USD")
                )
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .font(.largeTitle)
                .padding(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.secondary)
                    
                }
                
            }
            .card()
            .padding()
            
            // Name
            VStack(alignment:.leading) {
                Text("Name")
                    .fontWeight(.semibold)
                    .foregroundStyle(.accent)
                
                
                TextField("Expense Name", text:$expense.name)
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.secondary)
                        
                    }
                
            }
            .card()
            .padding()
            
            // Description
            VStack(alignment:.leading) {
                
                VStack(alignment:.leading){
                    Text("Description:")
                        .fontWeight(.semibold)
                        .foregroundStyle(.accent)
                    
                    TextField("Expense Description (Optional)",text: $expense.desc, axis: .vertical)
                        .multilineTextAlignment(.leading)
                        .frame(height: 64)
                        .padding(.horizontal)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(.secondary)
                            
                        }
                }
                
            }
            .card()
            .padding()
            
            // Date
            VStack(alignment:.leading) {
                Text("Date")
                    .fontWeight(.semibold)
                    .foregroundStyle(.accent)
                
                DatePicker(
                    "Date",
                    selection:  $expense.schedule.start,
                    displayedComponents: .date
                )
                .foregroundStyle(.secondary)
                
            }
            .card()
            .padding()
            
            // Categories
            VStack{
                LazyVGrid(
                    columns: [.init(.adaptive(minimum: 150), alignment: .center)]) {
                        ForEach(categories) {category in
                            Button {
                                if let index = expense.categories.firstIndex(of: category) {
                                    expense.categories.remove(at: index)
                                } else {
                                    expense.categories.append(category)
                                }
                            } label: {
                                if expense.categories.contains(category) {
                                    VStack(){
                                        Image(systemName: category.imageName)
                                            .imageScale(.large)
                                        Text(category.name)
                                    }
                                    .foregroundStyle(.gray)
                                    .padding(6)
                                } else {
                                    VStack(){
                                        Image(systemName: category.imageName)
                                            .imageScale(.large)
                                        Text(category.name)
                                    }
                                    .padding(6)
                                }
                            }
                        }
                    }
                
            }
            
            
          
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .frame(width: 150)
                        .foregroundStyle(.white)
                        .padding(16)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.top)
            
        }
        .toolbar {
            ToolbarItemGroup(placement:.topBarTrailing) {
                Button("Done") { dismiss() }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ModelPreview { expense in
        ExpensesEditView(expense:expense)
    }
}
