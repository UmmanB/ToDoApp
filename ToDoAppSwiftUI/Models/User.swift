//
//  User.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import Foundation

struct User: Codable
{
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
