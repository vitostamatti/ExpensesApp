//
//  ReportsView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI
import SwiftData
import Charts

// TODO: filter last 3 months and add a full 12 month plot on new view

struct ReportsView: View {
    @ObservedObject var viewModel = ReportsViewModel()
    @Query(sort:\Expense.schedule.start) var expenses:[Expense]
        
    var body: some View {
        ScrollView {
            
            TotalBalanceCardView(balance: viewModel.totalBalanceResult)
            
            HStack {
    
                MonthlyChangeCardView(monthlyPercentageChange: viewModel.monthlyPercentageChange)
                
                WeeklyChangeCardView(weeklyPercentageChange: viewModel.weeklyPercentageChange)
                
            }
            
            MonthlyBalanceCardView(monthlyBalance: viewModel.monthlyBalanceResult)
            
            DailyBalanceCardView(dailyBalance: viewModel.dailyBalanceResult)
            
            CategoriesExpensesCardView(categoriesResult: viewModel.categoriesResult)
            
        }
        .onAppear {
            Task { @MainActor in
                viewModel.totalBalance(expenses: expenses)
                viewModel.monthlyBalance(expenses: expenses)
                viewModel.dailyBalance(expenses: expenses)
                viewModel.categoriesBalance(expenses: expenses)
                viewModel.weeklyPercentageChange(expenses:expenses)
                viewModel.monthlyPercentageChange(expenses:expenses)
            }
        }
    }
}


#Preview {
    ReportsView()
        .appDataContainer(inMemory: true)
}
