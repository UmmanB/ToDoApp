//
//  LoginViewViewModel.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject
{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showErrorAlert = false
   
    init() {}
    
    func login()
    {
        guard validate() else
        {
            return
        }
        
        // Try log in
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool
    {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else
        {
            
            errorMessage = "Please fill in all the fields."
            showErrorAlert = true
            return false
        }
        
        guard email.contains("@") && email.contains(".") else
        {
            errorMessage = "Please enter a valid email address."
            showErrorAlert = true
            return false
        }
        
        return true
    }
}
