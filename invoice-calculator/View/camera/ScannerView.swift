//
//  ScannerView.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 12.11.2022.
//

import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    var didCancelScanning: () -> Void
    var didFinishScannning: ((_ result: Result<[UIImage], Error>) -> Void)
  
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
    
  
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let scannerView: ScannerView
        
        init(with scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            scannerView.didCancelScanning()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            scannerView.didFinishScannning(.failure(error))
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var scannedPages = [UIImage]()
            
            for i in 0..<scan.pageCount {
                scannedPages.append((scan.imageOfPage(at: i)))
            }
            
            //scannerView.didFinishScanning(.success(scannedPages))
        }
        
        
    }
  
    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }
    
    
    
}
