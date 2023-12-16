//
//  ContentView.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        AppTabView()
    }
}




#Preview {
    ContentView()
        .appDataContainer(inMemory: true)
}
