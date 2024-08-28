//
//  NewItemView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct NewItemView: View
{
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View
    {
        VStack
        {
            VStack(alignment: .leading, spacing: 8)
            {
                Text("Title")
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                TextField("Enter title", text: $viewModel.title)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 8)
            {
                Text("Due Date")
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                DatePicker("", selection: $viewModel.dueDate)
                
                    .datePickerStyle(CompactDatePickerStyle())
                    .accentColor(.indigo)
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            
            TLButton(title: "Save",
                     background: LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                                                startPoint: .leading,
                                                endPoint: .trailing))
            {
                if viewModel.canSave
                {
                    viewModel.save()
                    newItemPresented = false
                }
                else
                {
                    viewModel.showErrorAlert = true
                }
            }
            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 50)
            .padding(.top, 30)
            .padding(.bottom, 20)
            
            Spacer()
        }
        .alert(isPresented: $viewModel.showErrorAlert)
        {
            Alert(title: Text("Error"),
                  message: Text("Please fill in all the fields and select a due date that is today or newer."))
        }
    }
}

#Preview
{
    NewItemView(newItemPresented: Binding(get: { return true }, set: { _ in }))
}
