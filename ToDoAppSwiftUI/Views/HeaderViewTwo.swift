//
//  HeaderViewTwo.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 28.08.24.
//

import SwiftUI

struct HeaderViewTwo: View
{
    var title: String
    var subtitle: String
    
    var body: some View {
        ZStack(alignment: .top)
        {
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo, Color.purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 130)
            .mask(
                VStack
                {
                    RoundedRectangle(cornerRadius: 80, style: .continuous)
                        .frame(height: 160)
                        .frame(width: 450)
                        .offset(y: 0)
                })
            .ignoresSafeArea(edges: .top)
            
            HStack(alignment: .center, spacing: 10)
            {
                Text(title)
                    .font(.system(size: 35))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .offset(y: -54)
                
                Text(subtitle)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: -55)
            }
            .padding(.top, 60)
            .padding(.horizontal)
        }
    }
}
