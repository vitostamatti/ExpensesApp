//
//  AppScreen.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import Foundation
import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case expenses
    case add
    case reports
    
    var id: AppScreen { self }
}


extension AppScreen {
//    @ViewBuilder
//    var label: some View {
//        switch self {
//        case .expenses:
//            Label {
//                Text("Expenses")
//            } icon: {
//                Image(systemName: "house")
//            }
//        case .add:
//            Label {
//                Text("Add")
//            } icon: {
//                Image(systemName: "plus.circle")
//            }
//        case .reports:
//            Label {
//                Text("Reports")
//            } icon: {
//                Image(systemName: "chart.pie.fill")
//            }
//        }
//    }
//    
//    @ViewBuilder
//    var destination: some View {
//        switch self {
//        case .expenses:
//            ExpensesView()
//        case .add:
//            AddExpenseView()
//        case .reports:
//            ReportsView()
//        }
//    }
}
