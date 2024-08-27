//
//  MainView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct MainView: View
{
    @StateObject var viewModel = MainViewViewModel()
    @State private var selectedTab: Tab = .house
    @State private var showingNewItemView: Bool = false
    
    init()
    {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View
    {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty
        {
            ZStack
            {
                VStack
                {
                    TabView(selection: $selectedTab)
                    {
                        ToDoListView(userId: viewModel.currentUserId)
                            .tag(Tab.house)
                        
                        ProfileView()
                            .tag(Tab.person)
                    }
                }
                
                VStack
                {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                    {
                        showingNewItemView = true
                    }
                }
            }
            .sheet(isPresented: $showingNewItemView) {
                NewItemView(newItemPresented: $showingNewItemView)
                    .presentationDetents([.fraction(0.4)])
            }
        }
        else
        {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View
    {
        TabView
        {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem
            {
                Label("Home", systemImage: "house")
            }
            
            ProfileView()
                .tabItem
            {
                Label("Profile", systemImage: "person.circle")
            }
        }
    }
}

#Preview
{
    MainView()
}
