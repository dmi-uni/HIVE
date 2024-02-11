//
//  SettingsViewModel.swift
//  Hive
//
//  Created by Danil Masnaviev on 19/01/24.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore

class SettingsViewModel: ObservableObject {
    init() {}
    
    @Published var user: User? = nil
    
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
    }
}
