//
//  AppTabView.swift
//  Expenses
//
//  Created by Vito Stamatti on 5/12/23.
//

import SwiftUI
import SwiftData

struct AppTabView: View {
    @State private var tabScreenSelection:AppScreen = .expenses
    var body: some View {
        TabView(selection:$tabScreenSelection) {
            ExpensesView()
                .tag(AppScreen.expenses)
                .tabItem {
                    Label {
                        Text("Expenses")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
            AddExpenseView(tabScreenSelection:$tabScreenSelection)
                .tag(AppScreen.add)
                .tabItem {
                    Label {
                        Text("Add")
                    } icon: {
                        Image(systemName: "plus.circle")
                    }
                }
            
            ReportsView()
                .tag(AppScreen.reports)
                .tabItem {
                    Label {
                        Text("Reports")
                    } icon: {
                        Image(systemName: "chart.pie.fill")
                    }
                }
        }
    }
}

#Preview {
    AppTabView()
       .appDataContainer(inMemory: true)
}
