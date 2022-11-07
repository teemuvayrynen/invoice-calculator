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
        TabView(selection: $selection) {
            Text("test")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            
            CameraView(isImagePickerDisplay: $isImagePickerDisplay, selection: $selection, selectedImage: $selectedImage)
                .tabItem {
                    Image(systemName: "plusminus.circle")
                    Text("Calculate")
                }
                .onAppear {
                    if (selectedImage == nil) {
                        self.isImagePickerDisplay.toggle()
                    }
                }
                .tag(1)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
