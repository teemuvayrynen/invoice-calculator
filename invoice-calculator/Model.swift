//
//  Model.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 12.11.2022.
//

import Foundation
import Vision

class RecognizedContent: ObservableObject {
    @Published var items = [Product]()
}

struct TempItem {
    var id: String = UUID().uuidString
    var text: String = ""
    var midY: CGFloat = 0.0
}

struct Product: Identifiable {
    var id: String = UUID().uuidString
    var name: String = ""
    var type: Int = 0
    var price: String = ""
}
