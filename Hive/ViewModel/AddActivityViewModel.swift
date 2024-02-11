//
//  AddActivityViewModel.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import Foundation
import SwiftUI

import FirebaseAuth
import FirebaseFirestore

class AddActivityViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var totalTime: TimeInterval = 0
    @Published var goal: TimeInterval = 7.0
    @Published var goalType: GoalType = .weekly
    @Published var color: Color = Color.blue
    @Published var showAlert = false
    
    init() {}
    
    func saveActivity() {
        guard canSave else {
            return
        }
        
        guard let uID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let dateFormatter = DateConverter.shared
        
        
        // Создание модели
        let newID = UUID().uuidString
        
        let newActivity = Activity(
            id: newID,
            title: title,
            dateAdded: dateFormatter.stringFromDate(Date()),
            totalTime: totalTime,
            goal: goal * 60 * 60,
            goalType: goalType.rawValue,
            goalCompleted: 0,
            color: color.toHexString()
        )
        
        // Сохранение модели
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uID)
            .collection("activities")
            .document(newID)
            .setData(newActivity.asDictionary())
        
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard goal > 0 else {
            return false
        }
        
        return true
    }
}
