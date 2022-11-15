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
    @EnvironmentObject var model: FiretoreManager
    
    var searchResult: [Product] {
        if (searchText.isEmpty) {
            return model.products
        } else {
            return model.products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func delete(at offset: IndexSet) {
        for i in offset {
            model.deleteData(id: model.products[i].id)
        }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResult) { item in
                    TypePicker(item: item, cameraView: false)
                }.onDelete(perform: delete)
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
    var item: Product
    var cameraView: Bool
    var buttons = ["Nothing", "Custom", "Half"]
    @State private var selectedType: Int = 0
    @EnvironmentObject var model: FiretoreManager
    
    var body: some View {
        HStack {
            if (cameraView) {
                Text(item.price)
            }
            Text(item.name)
            Spacer()
            Picker("Numerator", selection: $selectedType) {
                ForEach(0..<3, id: \.self) {
                    Text(buttons[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: cameraView ? 150 : 190)
            .onChange(of: selectedType) { newValue in
                if (cameraView) {
                    
                } else {
                    model.updateData(id: item.id, type: newValue)
                }
            }
            
        }
        .onAppear {
            selectedType = item.type
        }
    }
}
