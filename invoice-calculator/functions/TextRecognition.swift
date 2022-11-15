//
//  TextRecognition.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 12.11.2022.
//

//0.019508004188537598

import SwiftUI
import Vision

struct TextRecognition {
    var scannedImage: UIImage
    @ObservedObject var recognizedContent: RecognizedContent
    @ObservedObject var model: FiretoreManager
    var didFinishRecognition: () -> Void
    
    private func createObjects(tempArray: [TempItem]) {
        for item in tempArray {
            let formatted = item.text.replacingOccurrences(of: " ", with: "")
            let products = model.products.filter { $0.name.replacingOccurrences(of: " ", with: "").getLevenshtein(target: formatted) < 4 }

            if !products.isEmpty {
                let temp = tempArray.filter {
                    abs(item.midY - $0.midY) < 0.01
                }
                if !temp.isEmpty {
                    var textItem = Product()
                    textItem.name = item.text
                    textItem.price = temp[1].text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "B", with: "").replacingOccurrences(of: "A", with: "")
                    textItem.type = products[0].type
                    DispatchQueue.main.async {
                        recognizedContent.items.append(textItem)
                    }
                }
            }
        }
    }
    
    private func getTextRecognitionRequest() -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
     
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var tempArray: [TempItem] = []
            
            tempArray = observations.map { (observation) -> TempItem in
                var tempItem = TempItem()
                guard let recognizedText = observation.topCandidates(1).first else { return tempItem}

                tempItem.text = recognizedText.string
                tempItem.midY = observation.boundingBox.midY
                return tempItem
            }
            
            createObjects(tempArray: tempArray)
        }
     
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
     
        return request
        
    }
    
    func recognizeText() {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        queue.async {
            guard let cgImage = scannedImage.cgImage else { return }
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([getTextRecognitionRequest()])
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.sync {
                didFinishRecognition()
            }
        }
    }
    
    
}
