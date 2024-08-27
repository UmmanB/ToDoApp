//
//  TLButton.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct TLButton: View
{
    let title: String
    let background: LinearGradient
    let action: () -> Void
    
    var body: some View
    {
        Button(action:
                {
            action()
        })
        {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .background(background)
                .cornerRadius(20)
        }
    }
}

#Preview
{
    TLButton(title: "Title",
             background:LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
    {
        
    }
}
