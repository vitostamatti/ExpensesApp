//
//  CategoriesExpensesCardView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//


import SwiftUI

struct CategoriesExpensesCardView: View {
    var categoriesResult:[CategoriesReportDataElement]
    var body: some View {
        VStack {
            Text("Expenses by Categories")
                .font(.title2)
            
            CategoriesPieChartView(data: categoriesResult)
                .frame(height: 150)
        }
        .card()
        .padding(.horizontal)
    }
}

