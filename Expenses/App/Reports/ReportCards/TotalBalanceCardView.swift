//
//  TotalBalanceCardView.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//

import SwiftUI

struct TotalBalanceCardView: View {
    var balance:Double
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Current Balance")
                    .font(.title2)
                Spacer()
            }
            
            Text(
                balance,
                format: .currency(code: "USD")
            )
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.accent)
        }
        .card()
        .padding(.horizontal)
    }
}
