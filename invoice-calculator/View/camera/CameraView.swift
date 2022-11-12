//
//  CameraView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 7.11.2022.
//

import SwiftUI

struct CameraView: View {
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var isImagePickerDisplay: Bool
    @Binding var selection: Int
    @Binding var selectedImage: UIImage?
    @Binding var isPresentingConfirm: Bool
    @State var isRecognizing = false
    @StateObject var recognizedContent = RecognizedContent()
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                  isPresentingConfirm.toggle()
                }, label: {
                    Image(systemName: "camera").foregroundColor(Color.primary)
                })
                .padding(.horizontal, 12)
                .padding(.vertical, 14)
                .background(Color("insertBackground"))
                .cornerRadius(60)
                .shadow(radius: 6)
                .padding()
            }
            List(recognizedContent.items, id: \.self) { textItem in
                //Text(String(textItem.text))
            }
            
        }.sheet(isPresented: self.$isImagePickerDisplay,
            onDismiss: {
            if (selectedImage == nil) {
                selection = 0
            }
            },
            content: {
                ImagePickerView(sourceType: self.sourceType) { result in
                    selectedImage = result
                    isImagePickerDisplay = false
                    
                    isRecognizing = true
                    
                    TextRecognition(scannedImage: selectedImage!, recognizedContent: recognizedContent) {
                        isRecognizing = false
                    }
                    .recognizeText()
                } didCancelScanning: {
                    isImagePickerDisplay = false
            }
        })
    }

}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


