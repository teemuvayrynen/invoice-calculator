//
//  ContentView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI



struct ContentView: View {
    @State var isImagePickerDisplay = false
    @State private var selection = 0
    @State private var selectedImage: UIImage?

    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                
                CameraView(isImagePickerDisplay: $isImagePickerDisplay, selection: $selection, selectedImage: $selectedImage)
                    .tabItem {
                        Label("Calculate", systemImage: "plusminus.circle")
                    }
                    .onAppear {
                        if (selectedImage == nil) {
                            self.isImagePickerDisplay.toggle()
                        }
                    }
                    .tag(1)
                
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                       
                    }
                    .tag(2)
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                       
                    }
                    .tag(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
