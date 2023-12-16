//
//  ExpensesTopMenu.swift
//  Expenses
//
//  Created by Vito Stamatti on 8/12/23.
//

import SwiftUI

struct ExpensesTopMenuView:View {
    
    var body: some View {
        Menu {
            NavigationLink {
                ExpensesGroupsView()
            } label: {
                Text("Expenses Groups")
                Image(systemName: "bag.badge.plus")
            }
            NavigationLink {
                ProfileView()
            } label: {
                Text("Profile")
                Image(systemName: "person")
            }
        } label :{
            Image(systemName: "line.3.horizontal")
        }
    }
}

#Preview {
    ExpensesTopMenuView()
}
