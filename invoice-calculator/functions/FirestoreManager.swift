//
//  FirestoreManager.swift
//  invoice-calculator
//
//  Created by Teemu Väyrynen on 13.11.2022.
//

import Foundation
import Firebase

class FiretoreManager: ObservableObject {
    @Published var products = [Product]()
    
    func addData(name: String, type: Int) {
        if (name != "") {
            let formatted = name.replacingOccurrences(of: " ", with: "").lowercased()
            if (!products.contains(where: { $0.name.replacingOccurrences(of: " ", with: "").lowercased() == formatted })) {
                let db = Firestore.firestore()
                db.collection("products").addDocument(data: ["name": name, "type": type]) { error in
                    if (error == nil) {
                        self.getData()
                    }
                }
            }
        }
        
    }
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("products").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.products = snapshot.documents.map { d in
                            return Product(id: d.documentID,
                                           name: d["name"] as? String ?? "",
                                           type: d["type"] as? Int ?? 0)
                            
                        }
                    }
                }
            } else {
                
            }
        }
    }
    
    func updateData(id: String, type: Int) {
        let db = Firestore.firestore()
        db.collection("products").document(id).setData(["type": type], merge: true) { error in
            if error == nil {
                self.getData()
            }
        }
    }
    
    func deleteData(id: String) {
        let db = Firestore.firestore()
        db.collection("products").document(id).delete { error in
            if error == nil {
                self.products.removeAll { product in
                    return product.id == id
                }
            }
        }
    }
}
