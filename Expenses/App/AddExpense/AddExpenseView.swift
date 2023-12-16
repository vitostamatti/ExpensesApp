//
//  AddExpenseView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Binding var tabScreenSelection:AppScreen
    
    var body: some View {
        AddExpenseForm(tabScreenSelection:$tabScreenSelection)
    }
}


struct AddExpenseForm:View {
    @Environment(\.modelContext) private var modelContext

    @Binding var tabScreenSelection:AppScreen
    
    @ObservedObject private var viewModel = NewExpenseViewModel()
    
    @Query(sort:\ExpenseCategory.name) var categories:[ExpenseCategory]
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView{
                Text("New Expense")
                    .font(.title)
                    .fontWeight(.semibold)
                
                
                VStack {
                    HStack {
                        
                        TextField(
                            "Value",
                            value: $viewModel.value,
                            format:.currency(code: "USD")
                            
                        )
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .font(.largeTitle)
                    }
                    Divider()
                    ScrollView(.horizontal) {
                        HStack(spacing:16){
                            ForEach([5, 10, 15, 20, 25, 30, 35, 40, 45],id:\.self) { amount in
                                Button {
                                    viewModel.value = Double(amount)
                                } label: {
                                    Text("\(amount)")
                                        .font(.title2)
                                        .frame(height: 44)
                                        .padding(.horizontal)
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 1)
                                                .foregroundStyle(.secondary)
                                            
                                        }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .card()
                .padding()
                
                
                
                VStack(alignment:.leading) {
                    Text("Name")
                        .fontWeight(.semibold)
                    
                    
                    TextField("Expense Name", text: $viewModel.name)
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
                
                
                VStack(alignment:.leading) {
                    
                    VStack(alignment:.leading){
                        Text("Description:")
                            .fontWeight(.semibold)
                        
                        TextField("Expense Description (Optional)",text: $viewModel.desc, axis: .vertical)
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
                
                
                VStack(alignment:.leading) {
                    Text("Schedule")
                        .fontWeight(.semibold)
                    
                    DatePicker(
                        "Date",
                        selection: $viewModel.date,
                        displayedComponents: .date
                    )
                    .foregroundStyle(.secondary)
                    
                    // TODO: show complete schedule form
                    //                    HStack{
                    //                        Button {
                    //
                    //                        } label: {
                    //                            HStack{
                    //                                Spacer()
                    //                                VStack(spacing:3){
                    //
                    //                                    Text("More")
                    //                                    Image(systemName: "chevron.down")
                    //
                    //                                }
                    //                                Spacer()
                    //                            }
                    //                        }
                    //
                    //                    }
                }
                .card()
                .padding()
                
                
                
                
                LazyVGrid(columns: [.init(.adaptive(minimum: 150), alignment: .center)]) {
                    ForEach(categories) {category in
                        Button {
                            if let index = viewModel.selectedCategories.firstIndex(of: category) {
                                viewModel.selectedCategories.remove(at: index)
                            } else {
                                viewModel.selectedCategories.append(category)
                            }
                        } label: {
                            if viewModel.selectedCategories.contains(category) {
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
                    
                    //                    NavigationLink {
                    //                        Text("New Category")
                    //                    } label: {
                    //                        Text("New")
                    //                    }
                    
                }
                
            }
            .padding(.bottom, 60)
            .overlay(alignment: .bottom) {
                VStack{
                    Divider()
                        .padding(.bottom)
                    
                    Button{
                        createAndInsertNewExpense()
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .disabled(!viewModel.formIsValid)
                }
                .background(.thinMaterial)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        tabScreenSelection = .expenses
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
            .toolbar(
                tabScreenSelection == .add ? .hidden : .visible, for: .tabBar)
        }
        
    }
    
    func createAndInsertNewExpense() {
        let expense = viewModel.expense()
        modelContext.insert(expense)
        viewModel.reset()
        tabScreenSelection = .expenses
    }
}

#Preview {
    NavigationStack {
        AddExpenseView(tabScreenSelection: .constant(.add))
            .appDataContainer(inMemory: true)
    }
}
