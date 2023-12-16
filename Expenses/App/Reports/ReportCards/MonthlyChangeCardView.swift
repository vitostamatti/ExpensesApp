//
//  MonthlyChangeCardView.swift
//  Expenses
//
//  Created by Vito Stamatti on 14/12/23.
//


import SwiftUI

struct MonthlyChangeCardView:View {
    
   var monthlyPercentageChange: Double
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment:.center) {
                Text("Previous Month Change")
                    .multilineTextAlignment(.center)
                
                Text(String(
                    format: "%.2f",
                    100*monthlyPercentageChange)+"%"
                )
                .fontWeight(.semibold)
                .font(.title3)
                .foregroundStyle(.accent)
                
            }
            Spacer()
        }
        .card()
        .padding(.leading)
    }
}
