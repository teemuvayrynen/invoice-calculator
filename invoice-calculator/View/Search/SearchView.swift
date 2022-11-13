//
//  SearchView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 11.11.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var presentAlert: Bool = false
    @ObservedObject var model: FiretoreManager
    
    var searchResult: [Product] {
        if (searchText.isEmpty) {
            return model.products
        } else {
            return model.products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.products) { item in
                    TypePicker(name: item.name)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle( "Products")
            .toolbar(content: {
                Button(action: {
                    presentAlert = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
                .popover(isPresented: $presentAlert, content: {
                    AddProductView(presentAlert: $presentAlert)
                })
            })
            
        }

    }
}

struct TypePicker: View {
    var name: String
    var buttons = ["Nothing", "Custom", "Half"]
    @State private var selectedType: Int = 0
    
    
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Picker("Numerator", selection: $selectedType) {
                ForEach(0..<3, id: \.self) {
                    Text(buttons[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width:190)
            
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
