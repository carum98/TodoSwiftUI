//
//  TodoView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import SwiftUI

struct TodoView: View {
    @StateObject var vm = TodoViewModel()
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    @State private var selectedAction: TodoModel?
    
    let list: ListModel
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                TodoTile(todo: item)
                    .onTapGesture {
                        Task {
                            await vm.toggle(todo: item)
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button("Edit", action: {
                            selectedAction = item
                            showingSheet.toggle()
                        }).tint(.blue)
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Delete", action: {
                            selectedAction = item
                            showingAlert.toggle()
                        }).tint(.red)
                    }
            }
            .onMove { fromOffset, toOffset in
                Task {
                    let todo = vm.items[fromOffset.first!]
                    await vm.move(todo: todo, position: toOffset)
                    vm.items.move(fromOffsets: fromOffset, toOffset: toOffset)
                }
            }
        }
        .listStyle(.inset)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Are you sure you want to delete the Todo?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    Task {
                        await vm.remove(todo: selectedAction!)
                            
                        if let index = vm.items.firstIndex(of: selectedAction!) {
                            withAnimation(.spring()){
                                _ = vm.items.remove(at: index)
                            }
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .toolbar {
            Button {
                showingSheet.toggle()
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: { selectedAction = nil }) {
            FormTodoView(todo: selectedAction, list: list, todoViewModel: vm) {
                showingSheet.toggle()
            }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .task(id: list) {
            await vm.getData(id: list.id)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoView(list: ListModel.preview())
        }
    }
}
