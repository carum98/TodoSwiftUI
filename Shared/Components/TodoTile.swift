//
//  TodoTile.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 5/8/23.
//

import SwiftUI

struct TodoTile: View {
    let todoViewModel: TodoViewModel
    let todo: TodoModel
    let list: ListModel
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        HStack {
            Image(systemName: todo.is_complete ? "record.circle" : "circle")
                .foregroundColor(todo.is_complete ? .blue : nil)
            Text(todo.title)
        }
        #if !os(tvOS)
        .swipeActions(edge: .leading) {
            Button("Edit", action: {
                showingSheet.toggle()
            }).tint(.blue)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete", action: {
                showingAlert.toggle()
            }).tint(.red)
        }
        #endif
        .confirmationDialog(
             Text("Are you sure you want to delete the ToDo?"),
             isPresented: $showingAlert,
             titleVisibility: .visible
         ) {
             Button("Delete", role: .destructive) {
                 Task {
                     await todoViewModel.remove(todo: todo)

                     if let index = todoViewModel.items.firstIndex(of: todo) {
                         withAnimation(.spring()){
                             _ = todoViewModel.items.remove(at: index)
                         }
                     }
                 }
             }
         }
         .onTapGesture {
             Task {
                 await todoViewModel.toggle(todo: todo)
             }
         }
         .sheet(isPresented: $showingSheet) {
             FormTodoView(todo: todo, list: list, todoViewModel: todoViewModel) {
                 showingSheet.toggle()
             }
                 .presentationDetents([.medium])
                 .presentationDragIndicator(.visible)
         }
    }
}

struct TodoTile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoTile(todoViewModel: TodoViewModel(), todo: TodoModel.preview(), list: ListModel.preview())
                .previewLayout(.fixed(width: 300, height: 100))
        
        }
    }
}
