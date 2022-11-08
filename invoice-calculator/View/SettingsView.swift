//
//  SettingsView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 8.11.2022.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Style")) {
                    Toggle(isOn: $isDarkMode, label: {
                        Text("Dark mode")
                    })
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
