//
//  ToDoListView.swift
//  ToDoAppSwiftUI
//
//  Created by Umman on 22.08.24.
//

import SwiftUI
import FirebaseFirestore

struct ToDoListView: View
{
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    @State private var showAlert = false
    @State private var itemToDelete: ToDoListItem?
    @State private var timer: Timer?
    
    init(userId: String)
    {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var body: some View
    {
        NavigationView
        {
            GeometryReader { geometry in
                VStack(spacing: -44)
                {
                    HeaderViewTwo(title: "To Do", subtitle: "List")
                    
                    if items.isEmpty
                    {
                        Text("No tasks here yet. Tap the plus button to add a new to-do")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .padding(.horizontal, 60)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else
                    {
                        List
                        {
                            if !filteredLateItems().isEmpty
                            {
                                Section(header: sectionHeaderView(title: "Late", backgroundColor: .white, textColor: .red))
                                {
                                    ForEach(filteredLateItems()) { item in
                                        ToDoListItemView(item: item, isLate: true)
                                            .listRowBackground(Color.white)
                                            .swipeActions
                                        {
                                            Button("Delete")
                                            {
                                                itemToDelete = item
                                                showAlert = true
                                            }
                                            .tint(.red)
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                            }
                            
                            if !filteredTodayItems().isEmpty
                            {
                                Section(header: sectionHeaderView(title: "Today", backgroundColor: .white, textColor: .black))
                                {
                                    ForEach(filteredTodayItems()) { item in
                                        ToDoListItemView(item: item, isLate: false)
                                            .listRowBackground(Color.white)
                                            .swipeActions {
                                                Button("Delete")
                                                {
                                                    itemToDelete = item
                                                    showAlert = true
                                                }
                                                .tint(.red)
                                            }
                                            .listRowSeparator(.hidden)
                                    }
                                }
                            }
                            
                            if !filteredTomorrowItems().isEmpty
                            {
                                Section(header: sectionHeaderView(title: "Tomorrow", backgroundColor: .white, textColor: .black))
                                {
                                    ForEach(filteredTomorrowItems()) { item in
                                        ToDoListItemView(item: item, isLate: false)
                                            .listRowBackground(Color.white)
                                            .swipeActions
                                        {
                                            Button("Delete")
                                            {
                                                itemToDelete = item
                                                showAlert = true
                                            }
                                            .tint(.red)
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                            }
                            
                            ForEach(filteredSpecificDateItems(), id: \.key) { (date, items) in
                                Section(header: sectionHeaderView(title: dateFormatter.string(from: date), backgroundColor: .white, textColor: .black))
                                {
                                    ForEach(items) { item in
                                        ToDoListItemView(item: item, isLate: false)
                                            .listRowBackground(Color.white)
                                            .swipeActions
                                        {
                                            Button("Delete")
                                            {
                                                itemToDelete = item
                                                showAlert = true
                                            }
                                            .tint(.red)
                                        }
                                        .listRowSeparator(.hidden)
                                    }
                                }
                                
                            }
                            
                        }
                        .listRowSeparator(.hidden)
                        .listStyle(PlainListStyle())
                        .scrollIndicators(.hidden)
                        .background(Color.clear)
                        .padding(.bottom, 60)
                    }
                }
                .navigationBarHidden(true)
            }
            .alert(isPresented: $showAlert)
            {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete this item?"),
                    primaryButton: .destructive(Text("Delete"))
                    {
                        if let itemToDelete = itemToDelete
                        {
                            viewModel.delete(id: itemToDelete.id)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear
            {
                startTimer()
            }
            .onDisappear
            {
                stopTimer()
            }
        }
    }
    
    private func filteredLateItems() -> [ToDoListItem]
    {
        let now = Date()
        return items.filter { Date(timeIntervalSince1970: $0.dueDate) < now }
            .sorted { $0.dueDate < $1.dueDate }
    }
    
    private func filteredTodayItems() -> [ToDoListItem]
    {
        let calendar = Calendar.current
        let now = Date()
        return items.filter
        {
            let dueDate = Date(timeIntervalSince1970: $0.dueDate)
            return calendar.isDateInToday(dueDate) && dueDate > now
            
        }
        .sorted { $0.dueDate < $1.dueDate }
    }
    
    private func filteredTomorrowItems() -> [ToDoListItem]
    {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        return items.filter { calendar.isDate(Date(timeIntervalSince1970: $0.dueDate), inSameDayAs: tomorrow) }
            .sorted { $0.dueDate < $1.dueDate }
    }
    
    private func filteredSpecificDateItems() -> [(key: Date, value: [ToDoListItem])]
    {
        let calendar = Calendar.current
        let now = Date()
        
        let groupedItems = Dictionary(grouping: items.filter { Date(timeIntervalSince1970: $0.dueDate) >= now }) { item -> Date in
            let dueDate = Date(timeIntervalSince1970: item.dueDate)
            let components = calendar.dateComponents([.year, .month, .day], from: dueDate)
            return calendar.date(from: components)!
        }
        
        return groupedItems
            .filter { (date, _) in
                let today = Date()
                let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
                return !calendar.isDateInToday(date) && !calendar.isDate(date, inSameDayAs: tomorrow)
            }
            .sorted { $0.key < $1.key }
            .map { (date, items) in
                (date, items.sorted { $0.dueDate < $1.dueDate })
            }
    }
    
    private var dateFormatter: DateFormatter
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private func startTimer()
    {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            refreshData()
        }
    }
    
    private func stopTimer()
    {
        timer?.invalidate()
    }
    
    private func refreshData()
    {
        viewModel.objectWillChange.send()
    }
    
    
    private func sectionHeaderView(title: String, backgroundColor: Color, textColor: Color) -> some View
    {
        HStack
        {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(textColor)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            Spacer()
        }
        .background(backgroundColor)
        .cornerRadius(8)
        .listRowInsets(EdgeInsets())
    }
}

#Preview { ToDoListView(userId: "9HFdTgmQrHeL2rVMbqTszyrrWFJ3") }
