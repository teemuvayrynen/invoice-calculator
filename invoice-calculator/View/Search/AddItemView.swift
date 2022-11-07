//
//  InsertItemView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI

struct AddItemView: View {
    @State var textFieldString: String = ""
    @State var selectedIndex: Int = 0
    @State var focused = false
    
    let buttons = [
        "Half",
        "Custom",
        "Nothing"
    ]
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add", text: $textFieldString, onEditingChanged: {(editingChanged) in
                    if (editingChanged) {
                        focused = true
                    } else {
                        focused = false
                    }
                })
                    .padding()
                    .background(Color("buttonBackground"))
                    .withInputAndButtonFormatting(
                        foregroundColor: focused ? Color.blue : Color(UIColor.systemGray4)
                    )
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                })
            }.padding([.top, .leading, .trailing], 20.0).padding(.bottom, 10.0)
            HStack {
                ForEach(0..<3, id: \.self) { number in
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        Text(buttons[number])
                            .foregroundColor(number == selectedIndex ? Color.white : Color.primary)
                            .padding(12)
                            .background(number == selectedIndex ? Color.blue : Color("buttonBackground"))
                            .withInputAndButtonFormatting()
                            
                            
                    })
                }
                Spacer()
            }.padding([.leading, .bottom, .trailing], 20.0)
        }
        .modifier(DefaultBoxViewModifier())
          
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
