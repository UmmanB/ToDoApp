//
//  ToDoListItemView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI

struct ToDoListItemView: View
{
    @StateObject var viewModel = ToDoListItemViewViewModel()
    
    let item: ToDoListItem
    let isLate: Bool
    
    var body: some View
    {
        HStack
        {
            Button
            {
                viewModel.toggleIsDone(item: item)
            }
        label:
            {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle.fill")
                    .foregroundColor(item.isDone ? Color.indigo : Color.indigo)
                    .font(.system(size: 24))
            }
            .padding(.trailing, 10)
            
            VStack(alignment: .leading)
            {
                Text(item.title)
                    .font(.body)
                    .foregroundColor(item.isDone ? Color.gray : Color.primary)
                    .strikethroughStyle(isDone: item.isDone, isLate: isLate)
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            Image(systemName: "arrow.backward.circle.fill")
                .font(.system(size: 24))
                .foregroundColor(.purple)
        }
    }
}
