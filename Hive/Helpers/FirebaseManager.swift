//
//  FirebaseManager.swift
//  Hive
//
//  Created by Danil Masnaviev on 23/01/24.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func editField(collectionName: String, documentID: String, fieldToUpdate: String, newValue: Any, completion: @escaping (Error?) -> Void) {
        let updateData: [String: Any] = [
            fieldToUpdate: newValue
        ]
        
        db.collection(collectionName).document(documentID).updateData(updateData) { error in
            completion(error)
        }
    }
    
    func updateField(collectionName: String, documentID: String, fieldToUpdate: String, incrementBy: Double, completion: @escaping (Error?) -> Void) {
        db.collection(collectionName).document(documentID).updateData([
            fieldToUpdate: FieldValue.increment(incrementBy)
        ]) { error in
            completion(error)
        }
    }
}
