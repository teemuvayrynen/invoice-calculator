//
//  HomeView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 6.11.2022.
//

import SwiftUI

struct SearchView: View {
    var containerWidth:CGFloat = UIScreen.main.bounds.width - 32.0
    @State var searchField: String = ""
    @State var searchBooleans = [
        false,
        false,
        false
    ]
    
    var body: some View {
        VStack {
            AddItemView()
            SearchItemView(searchField: $searchField, searchBooleans: $searchBooleans)
            Text(String(searchBooleans[0]))
            Spacer()
        }.frame(maxWidth: containerWidth * 0.98)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
