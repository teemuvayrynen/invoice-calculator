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
    @ObservedObject var model: FiretoreManager
    @State private var selectedNumerator = 0
    @State private var selectedDivider = 0
    
    
    var body: some View {
        VStack {
            if (selectedImage != nil) {
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
            }
            if (!isRecognizing) {
                VStack {
                    Form {
                        Section(header: Text("Fraction")) {
                            Picker("Numerator", selection: $selectedNumerator) {
                                ForEach(1..<6) {
                                    Text("\($0)")
                                }
                            }
                            Picker("Divider", selection: $selectedDivider) {
                                ForEach(1..<6) {
                                    Text("\($0)")
                                }
                            }
                        }
                        Section(header: Text("Items")) {
                            HStack {
                                Text("Half product")
                                Spacer()
                                Image(systemName: "divide.circle")
                            }
                            HStack {
                                Text("Custom divide")
                                Spacer()
                                Image(systemName: "divide.square")
                            }
                            HStack {
                                Text("Payers product")
                                Spacer()
                                Image(systemName: "person.fill")
                            }
                        }
                        Section(header: Text("Products")) {
                            List(recognizedContent.items, id: \.self) { textItem in
                                Text(String(textItem.product))
                            }
                        }
                    }
                }
            } else {
                Spacer()
                ProgressView().progressViewStyle(.circular)
                Spacer()
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
                    
                    TextRecognition(scannedImage: selectedImage!, recognizedContent: recognizedContent, model: model) {
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


