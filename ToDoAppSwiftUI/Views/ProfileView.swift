//
//  ProfileView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct ProfileView: View
{
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var showingLogOutAlert = false
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                if let user = viewModel.user
                {
                    profile(user: user)
                }
                else
                {
                    Text("Loading Profile...")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.horizontal, 60)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Profile")
            .alert(isPresented: $showingLogOutAlert)
            {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Log Out"))
                    {
                        viewModel.logOut()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .onAppear
        {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View
    {
        VStack(spacing: 20)
        {
            ZStack
            {
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .mask(Circle())
                .frame(width: 100, height: 100)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 125, height: 125)
            }
            .background(Circle().fill(Color.white))
            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                profileRow(title: "Name:", value: user.name)
                profileRow(title: "Email:", value: user.email)
                profileRow(title: "Member Since:", value: "\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding(.horizontal, 20)
            
            TLButton(title: "Log Out",
                     background: LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing))
            {
                showingLogOutAlert = true
            }
            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
        }
        .padding()
    }
    
    @ViewBuilder
    func profileRow(title: String, value: String) -> some View
    {
        HStack
        {
            Text(title)
                .fontWeight(.bold)
                .frame(width: 150, alignment: .leading)
            Text(value)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView()
}
