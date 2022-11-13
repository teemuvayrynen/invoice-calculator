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
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("products").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.products = snapshot.documents.map { d in
                            return Product(id: d.documentID,
                                           name: d["name"] as? String ?? "",
                                           type: d["type"] as? String ?? "")
                            
                        }
                    }
                }
            } else {
                
            }
        }
         
    }
}
