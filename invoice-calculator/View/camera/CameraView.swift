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
    @EnvironmentObject var model: FiretoreManager
    
    @State private var selectedNumerator = 0
    @State private var selectedDivider = 0
    
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    if (!isRecognizing && selectedImage != nil) {
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
                            Section(header: Text("Products")) {
                                List(recognizedContent.items) { item in
                                    TypePicker(item: item, cameraView: true)
                                }
                            }
                        }
                    } else if (selectedImage != nil && isRecognizing) {
                        Spacer()
                        ProgressView().progressViewStyle(.circular)
                        Spacer()
                    }
                }.toolbar {
                    if selectedImage != nil {
                        Button(action: {
                            isPresentingConfirm.toggle()
                        }, label: {
                            Image(systemName: "camera").foregroundColor(Color.primary)
                        })
                    }
                }
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
                    recognizedContent.items.removeAll()
                    
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
