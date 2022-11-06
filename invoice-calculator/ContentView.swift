//
//  ContentView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Text("test")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            
            Text("Camera")
                .tabItem {
                    Image(systemName: "camera")
                        
                        
                    Text("Camera")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
