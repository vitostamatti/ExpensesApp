//
//  WeeklyChangeCardView.swift
//  Expenses
//
//  Created by Vito Stamatti on 14/12/23.
//

import SwiftUI

struct WeeklyChangeCardView:View {
    
   var weeklyPercentageChange: Double
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment:.center) {
                Text("Previous Week Change")
                    .multilineTextAlignment(.center)
                
                Text(String(
                    format: "%.2f",
                    100*weeklyPercentageChange)+"%"
                )
                .fontWeight(.semibold)
                .font(.title3)
                .foregroundStyle(.accent)
                
            }
            Spacer()
        }
        .card()
        .padding(.trailing)
    }
}
