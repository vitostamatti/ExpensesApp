//
//  ViewModifiers.swift
//  Expenses
//
//  Created by Vito Stamatti on 12/12/23.
//
import SwiftUI

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 8)
        
    }
}

extension View {
    func card() -> some View {
        modifier(CardViewModifier())
    }
}

