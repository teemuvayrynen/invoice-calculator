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
    
    
    var body: some View {
        VStack {
            if selectedImage != nil {
                HStack {
                    Spacer()
                    Button(action: {
                        selectedImage = nil
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
                Spacer()
                
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
                
                Spacer()
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
