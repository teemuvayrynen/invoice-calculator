//
//  HomeView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 8.11.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedNumerator = 0
    @State private var selectedDivider = 0
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Fraction")) {
                    Picker("Numerator", selection: $selectedNumerator) {
                        ForEach(1..<6) {
                            Text("\($0)")
                        }
                    }
                    Picker("Divider", selection: $selectedDivider) {
                        ForEach(1..<6) {
                            Text("\($0)")
                        }
                    }
                }
                Section(header: Text("Items")) {
                    HStack {
                        Text("Half product")
                        Spacer()
                        Image(systemName: "divide.circle")
                    }
                    HStack {
                        Text("Custom divide")
                        Spacer()
                        Image(systemName: "divide.square")
                    }
                    HStack {
                        Text("Payers product")
                        Spacer()
                        Image(systemName: "person.fill")
                    }
                }
                Section(header: Text("Products")) {
                    
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
