//
//  HeaderView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct HeaderView: View
{
    let title: String
    let subtitle: String
    let subtitleTwo: String
    let angle: Double
    let background: LinearGradient
    
    var body: some View
    {
        ZStack
        {
            background
                .rotationEffect(Angle(degrees: angle))
            
            VStack
            {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                
                HStack
                {
                    Text(subtitle)
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                        .fontWeight(.light)
                        .offset(x: 10)
                    
                    Text(subtitleTwo)
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                        .bold()
                }
            }
            .padding(.top, 90)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
    }
}

#Preview
{
    HeaderView(title: "Title", subtitle: "Subtitle ", subtitleTwo: "SubtitleTwo", angle: 15,
               background:LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
}
