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
            
            VStack(alignment: .leading) {
                           Text(item.title)
                               .font(.body)
                               .foregroundColor(item.isDone ? Color.gray : Color.primary) // Change text color when checked
                               .strikethroughStyle(isDone: item.isDone, isLate: isLate) // Apply the custom strikethrough style
                           
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            Spacer()
        }
    }
}

//#Preview
//{
//    ToDoListItemView(item: ToDoListItem(id: "123", title: "Get milk", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: true))
//}
