//
//  LoginView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct LoginView: View
{
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                // Header
                HeaderView(title: "To do App", subtitle: "get things ", subtitleTwo: "DONE.", angle: 15,
                           background: LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                                                      startPoint: .topLeading,
                                                      endPoint: .bottomTrailing))
                
                // Login Form
                Spacer() .frame(height: 30)
                VStack(spacing: 20) {
                    TextField("Email address", text: $viewModel.email)
                        .padding()
                        .background(Color(.white))
                        .autocapitalization(.none)
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    TLButton(title: "Log In",
                             background:LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing))
                    {
                        viewModel.login()
                    }
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                }
                .padding()
                
                // Create Account
                VStack
                {
                    Text("Don't have an account yet?")
                        .foregroundColor(.gray)
                        .fontWeight(.regular)
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    NavigationLink(destination: RegisterView())
                    {
                        Text("Create an Account")
                            .foregroundColor(.indigo)
                            .fontWeight(.semibold)
                            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                }
                .padding()
                Spacer()
            }
            .alert(isPresented: $viewModel.showErrorAlert)
            {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview
{
    LoginView()
}
