//
//  CameraView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 7.11.2022.
//

import SwiftUI

struct CameraView: View {
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var isImagePickerDisplay: Bool
    @Binding var selection: Int
    @Binding var selectedImage: UIImage?
    
    
    var body: some View {
        ZStack {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
            }
            
        }.sheet(isPresented: self.$isImagePickerDisplay,
            onDismiss: {
                if (selectedImage == nil) {
                    selection = 0
                }
            },
            content: {
            ImagePickerView(selectedImage: self.$selectedImage, selection: self.$selection, sourceType: self.sourceType).background(.black)
        })
    }

}
