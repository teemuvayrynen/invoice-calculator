//
//  SearchView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 11.11.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var productName: String = ""
    @State private var presentAlert: Bool = false
    @State private var selectedType: Int = 0
    
    var names = ["kakka", "kissa", "poissa", "kkkD", "JDIJWID"]
    
    var buttons = ["Nothing", "Custom", "Half"]
    
    var searchResult: [String] {
        if (searchText.isEmpty) {
            return names
        } else {
            return names.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResult, id: \.self) { name in
                    Text(name)
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
                    VStack {
                        HStack {
                            Text("Add Product")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(0)
                            
                            Spacer()
                            Button(action: {
                                presentAlert = false
                            }, label: {
                                Circle()
                                    .fill(Color(.secondarySystemBackground))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: "xmark")
                                            .font(.system(size: 12, weight: .bold, design: .rounded))
                                            .foregroundColor(.secondary)
                                    )
                            })
                        }
                        .padding(.top, 30.0)
                        .padding(.bottom, 10)
                        Picker("Numerator", selection: $selectedType) {
                            ForEach(0..<3, id: \.self) {
                                Text(buttons[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        TextField("Name", text: $productName)
                            .padding(8)
                            .padding(.leading, 10)
                            .background(Color("inputBackground"))
                            .cornerRadius(10)
                            .padding(.top, 10)
                        
                        Button(action: {
                            productName = ""
                        }, label: {
                            Text("Done").foregroundColor(Color.white)
                        })
                        .padding(12)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.top, 20)
                            
                        Spacer()
                    }
                    .padding(.horizontal, 20.0)
                    .presentationDetents([.fraction(0.35)])
                })
            })
            
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
