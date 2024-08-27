//
//  RegisterView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct RegisterView: View
{
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View
    {
        VStack
        {
            // Header
            HeaderView(title: "Register", subtitle: "Start organizing ", subtitleTwo: "TODOS", angle: -15,
                       background: LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.purple]),
                                                  startPoint: .bottomLeading,
                                                  endPoint: .topTrailing))
            
            // Register Form
            Spacer().frame(height: 30)
            VStack(spacing: 20)
            {
                TextField("Full Name", text: $viewModel.name)
                    .padding()
                    .background(Color(.white))
                    .autocorrectionDisabled()
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                
                TextField("Email Address", text: $viewModel.email)
                    .padding()
                    .background(Color(.white))
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                
                TLButton(title: "Create Account",
                         background:LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.purple]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                {
                    viewModel.register()
                }
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                
                // Custom Back Button
                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                        .fontWeight(.regular) +
                    Text(" Log In")
                        .foregroundColor(.indigo)
                        .fontWeight(.semibold)
                }
                .padding()
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            .padding()
            Spacer()
            
                .alert(isPresented: $viewModel.showErrorAlert)
            {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
}

#Preview
{
    RegisterView()
}
