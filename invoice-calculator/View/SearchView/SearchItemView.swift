//
//  SearchItemView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI

struct SearchItemView: View {
    @Binding var searchField: String
    @State var focused = false
    @Binding var searchBooleans: [Bool]
    let buttons = [
        "Half",
        "Custom",
        "Nothing"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchField, onEditingChanged: {(editingChanged) in
                    if (editingChanged) {
                        focused = true
                    } else {
                        focused = false
                    }
                })
                    .cornerRadius(10)
            }
            .padding()
            .background(Color("buttonBackground"))
            .withInputAndButtonFormatting(
                foregroundColor: focused ? Color.blue : Color(UIColor.systemGray4)
            )
            .padding([.top, .leading, .trailing], 20.0)
            .padding(.bottom, 10.0)
            
            HStack {
                ForEach(0..<3, id: \.self) { number in
                    Button(action: {
                        searchBooleans[number] = !searchBooleans[number]
                    }, label: {
                        Text(buttons[number])
                            .foregroundColor(searchBooleans[number] ? Color.white : Color.primary)
                            .padding(12)
                            .background(searchBooleans[number] ? Color.blue : Color("buttonBackground"))
                            .withInputAndButtonFormatting()
                    })
                }
                Spacer()
            }.padding([.leading, .bottom, .trailing], 20.0)
        }
        .modifier(DefaultBoxViewModifier())
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(searchField: .constant(""), searchBooleans: .constant([false, false, false]))
    }
}
