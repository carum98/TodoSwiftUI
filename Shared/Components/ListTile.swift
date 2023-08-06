//
//  ListTile.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import SwiftUI

struct ListTile: View {
    let listViewModel: ListViewModel
    
    let list: ListModel
    let swipeActions: Bool = false
    
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .frame(width: 20, height: 20)
                .foregroundColor(Color(hex: list.color))
            Text(list.name)
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
             Text("Are you sure you want to delete the List?"),
             isPresented: $showingAlert,
             titleVisibility: .visible
         ) {
             Button("Delete", role: .destructive) {
                 Task {
                     await listViewModel.remove(id: list.id)

                     if let index = listViewModel.items.firstIndex(of: list) {
                         withAnimation(.spring()){
                             _ = listViewModel.items.remove(at: index)
                         }
                     }
                 }
             }
         }
        .sheet(isPresented: $showingSheet) {
            FormListView(list: list, listViewModel: listViewModel) {
                showingSheet.toggle()
            }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

struct ListTile_Previews: PreviewProvider {
    static var previews: some View {
        ListTile(listViewModel: ListViewModel(), list: ListModel.preview())
    }
}
