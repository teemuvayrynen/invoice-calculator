//
//  ContentView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI


struct ContentView: View {
    @State var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selection = 0
    @State private var selectedImage: UIImage?
    @State private var isPresentingConfirm: Bool = false
    @ObservedObject var model = FiretoreManager()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        model.getData()
    }

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
              
                CameraView(sourceType: $sourceType, isImagePickerDisplay: $isImagePickerDisplay, selection: $selection, selectedImage: $selectedImage, isPresentingConfirm: $isPresentingConfirm, model: model)
                    .tabItem {
                        Label("Calculate", systemImage: "plusminus.circle")
                    }
                    .onAppear {
                        if (selectedImage == nil) {
                            self.isPresentingConfirm.toggle()
                        }
                    }
                    .confirmationDialog("Are you sure?",
                                        isPresented: $isPresentingConfirm) {
                        Button("Camera") {
                            self.sourceType = .camera
                            self.isImagePickerDisplay.toggle()
                        }
                        Button("Photo") {
                            self.sourceType = .photoLibrary
                            self.isImagePickerDisplay.toggle()
                        }
                        Button("Cancel", role: .cancel) {
                            if (selectedImage == nil) {
                                selection = 0
                            }
                        }
                    }
                    .tag(1)
                    
                  
                SearchView(model: model)
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
