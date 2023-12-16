//
//  DailyBalanceCardView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//

import SwiftUI

struct DailyBalanceCardView: View {
    var dailyBalance:[ReportDataElement]
    var body: some View {
        VStack {
            Text("Daily Balance")
                .font(.title2)
            
            DailyBalanceBarCharView(data: dailyBalance)
                .frame(height: 150)
        }
        .card()
        .padding(.horizontal)
    }
}
