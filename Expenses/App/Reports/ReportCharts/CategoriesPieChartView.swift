//
//  CategoriesPieChartView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//

import SwiftUI
import Charts

struct CategoriesPieChartView: View {
    var data:[CategoriesReportDataElement]
    
    var body: some View {
        Chart(data, id: \.categoryName) { element in
          SectorMark(
            angle: .value("Expenses", element.value),
            innerRadius: .ratio(0.618),
            angularInset: 1.5
          )
          .cornerRadius(5)
          .foregroundStyle(by: .value("Name", element.categoryName))
        }
    }
}
