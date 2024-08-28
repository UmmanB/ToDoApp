//
//  CustomTabBar.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 23.08.24.
//

import SwiftUI

enum Tab: String, CaseIterable
{
    case house
    case person
}

struct CustomTabBar: View
{
    @Binding var selectedTab: Tab
    var onPlusButtonTap: () -> Void
    
    private var fillImage: String
    {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color
    {
        .indigo
    }
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? tabColor : .gray)
                        .font(.system(size: 20))
                        .onTapGesture
                    {
                        withAnimation(.easeInOut(duration: 0.1))
                        {
                            selectedTab = tab
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 1, height: 35)
                    .padding(.horizontal, 15)
                
                Button(action: onPlusButtonTap)
                {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.purple)
                }
                
                Spacer()
            }
            .frame(width: 200, height: 60)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: .gray, radius: 5, x: 0, y: 2)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider
{
    static var previews: some View
    {
        CustomTabBar(selectedTab: .constant(.house), onPlusButtonTap: {})
    }
}
