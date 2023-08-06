//
//  ListView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var vm = ListViewModel()
    @Binding var selected: ListModel?
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    @State private var selectedAction: ListModel?
    
    var body: some View {
        #if os(watchOS)
        List(vm.items) { item in
            NavigationLink(value: item) {
                ListTile(list: item)
            }
        }
        .navigationDestination(for: ListModel.self) { item in
            TodoView(list: item)
                .navigationTitle(item.name)
        }
        .task {
            await vm.getData()
        }
        #else
        List(vm.items, selection: $selected) { item in
            NavigationLink(value: item) {
                ListTile(list: item)
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
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Are you sure you want to delete the List?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    Task {
                        await vm.remove(id: selectedAction!.id)
                            
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
            FormListView(list: selectedAction, listViewModel: vm) {
                showingSheet.toggle()
            }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .task {
            await vm.getData()
        }
        #endif
    }
}

struct ListView_Preview: PreviewProvider {
    static var previews: some View {
        @State var list: ListModel?
        
        NavigationSplitView {
            ListView(selected: $list)
                .navigationTitle("Lists")
        } detail: {
            Text("Select list")
        }
    }
}
