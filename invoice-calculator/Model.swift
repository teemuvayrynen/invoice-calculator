//
//  Model.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 12.11.2022.
//

import Foundation
import Vision

class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}

struct TextItem: Hashable {
    var product: String = ""
    var price: String = ""
}

struct TempItem {
    var id: String = UUID().uuidString
    var text: String = ""
    var midY: CGFloat = 0.0
}
