//
//  LoginViewModel.swift
//  Hive
//
//  Created by Danil Masnaviev on 18/01/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Заполните все поля!"
            return false
        }
        
        guard Validator.validateEmail(email), Validator.validatePassword(password) else {
            errorMessage = "Введите верный email адрес"
            return false
        }
        
        return true
    }
}
