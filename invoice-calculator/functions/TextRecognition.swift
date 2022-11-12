//
//  TextRecognition.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 12.11.2022.
//

import SwiftUI
import Vision

struct TextRecognition {
    var scannedImage: UIImage
    @ObservedObject var recognizedContent: RecognizedContent
    var didFinishRecognition: () -> Void
    
    private func createObjects(tempArray: [TempItem]) {
        tempArray.forEach { first in
            tempArray.forEach { second in
                if (first.text != second.text && abs(first.midY - second.midY) < 0.01) {
                    
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
     
            observations.forEach { observation in
                guard let recognizedText = observation.topCandidates(1).first else { return }
                var tempItem = TempItem()
                tempItem.text = recognizedText.string
                tempItem.midY = observation.boundingBox.midY
                tempArray.append(tempItem)
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
