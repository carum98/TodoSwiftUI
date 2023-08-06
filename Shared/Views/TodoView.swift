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
    
    @State private var selectedAction: TodoModel?
    
    let list: ListModel
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                TodoTile(todoViewModel: vm, todo: item, list: list)
            }
            .onMove { fromOffset, toOffset in
                Task {
                    let todo = vm.items[fromOffset.first!]
                    await vm.move(todo: todo, position: toOffset)
                    vm.items.move(fromOffsets: fromOffset, toOffset: toOffset)
                }
            }
        }
        #if os(watchOS)
        .listStyle(.carousel)
        #elseif os(tvOS)
        .listStyle(.automatic)
        #else
        .listStyle(.inset)
        #endif
        .toolbar {
            Button {
                showingSheet.toggle()
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showingSheet) {
            FormTodoView(todo: nil, list: list, todoViewModel: vm) {
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
