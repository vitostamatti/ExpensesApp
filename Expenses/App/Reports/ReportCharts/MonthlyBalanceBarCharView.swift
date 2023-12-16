//
//  MonthlyBalanceBarCharView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//

import SwiftUI
import Charts


struct MonthlyBalanceBarCharView: View {
    var data:[ReportDataElement]
    
    var body: some View {
        Chart(data) { element in
            BarMark(
                x: .value("Date", element.date, unit: .month),
                y: .value("Balance", element.value)
            )
            .annotation(position: .top, alignment: .center) {
                Text(
                    element.value,
                    format: .currency(code: "USD")
                )
                .font(.footnote)
                .foregroundColor(.accentColor)
             }
        }
        .chartYAxis {
            AxisMarks(position:.leading, values: .automatic(desiredCount: 4))
        }
        .chartXAxis {
            AxisMarks(
                values: .automatic(desiredCount: data.count)
            )
        }
    }
}
