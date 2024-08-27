//
//  StrikethroughStyle.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 24.08.24.
//

import SwiftUI

struct StrikethroughStyle: ViewModifier
{
    let isDone: Bool
    let isLate: Bool
    
    func body(content: Content) -> some View
    {
        content
            .overlay(
                GeometryReader { geometry in
                    if isDone
                    {
                        Rectangle()
                            .fill(isLate ? Color.red : Color.gray)
                            .frame(height: 2)
                            .offset(y: geometry.size.height / 2)
                    }
                }
            )
    }
}

extension View
{
    func strikethroughStyle(isDone: Bool, isLate: Bool) -> some View
    {
        self.modifier(StrikethroughStyle(isDone: isDone, isLate: isLate))
    }
}
