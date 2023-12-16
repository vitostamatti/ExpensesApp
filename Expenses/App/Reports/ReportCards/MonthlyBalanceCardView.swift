//
//  MonthlyBalanceCardView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//

import SwiftUI

struct MonthlyBalanceCardView: View {
    var monthlyBalance:[ReportDataElement]
    
    var body: some View {
        VStack {
            Text("Monthly Balance")
                .font(.title2)
            
            MonthlyBalanceBarCharView(
                data: monthlyBalance
            )
            .frame(height: 150)
            
        }
        .card()
        .padding(.horizontal)
    }
}
