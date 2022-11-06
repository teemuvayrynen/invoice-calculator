//
//  BoxViewModifier.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI

extension View {
    func withInputAndButtonFormatting(foregroundColor: Color = Color(UIColor.systemGray4)) -> some
        View {
        modifier(InputAndButtonViewModifier(foregroundColor: foregroundColor))
    }
}

struct DefaultBoxViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("insertBackground"))
            .clipped()
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.bottom, 10.0)
    }
}

struct InputAndButtonViewModifier: ViewModifier {
    
    let foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(foregroundColor))
            
    }
}
