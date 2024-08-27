//
//  ToDoAppSwiftUIApp.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI
import FirebaseCore

@main
struct ToDoAppSwiftUIApp: App
{
    init()
    {
        FirebaseApp.configure()
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            MainView()
        }
    }
}
