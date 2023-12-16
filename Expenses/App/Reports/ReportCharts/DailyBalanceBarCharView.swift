//
//  DailyBalanceBarCharView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//

import SwiftUI
import Charts

struct DailyBalanceBarCharView: View {
    var data:[ReportDataElement]
    
    var body: some View {
        Chart(data) { element in
            BarMark(
                x: .value("Date", element.date, unit:.day),
                y: .value("Balance", element.value)
            )
            .interpolationMethod(.catmullRom)
        }
        .chartYAxis {
            AxisMarks(position:.leading)
        }
        .chartXAxis {
            AxisMarks(
                values: .automatic(desiredCount: data.count)
            )
        }
    }
}
