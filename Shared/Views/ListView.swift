//
//  ListView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var vm: ListViewModel
    @Binding var selected: ListModel?
    
    @State private var showingSheet = false
    
    private let listWithSelection: Bool
    
    init() {
        self._selected = Binding.constant(nil)
        self.listWithSelection = false
    }
    
    init(selected: Binding<ListModel?>) {
        self._selected = selected
        self.listWithSelection = true
    }
    
    @ViewBuilder
    func ListBuilder(items: [ListModel], rowContent: @escaping (ListModel) -> some View) -> some View {
        if self.listWithSelection {
            #if os(watchOS)
                List(items, rowContent: rowContent)
            #else
                List(items, selection: $selected, rowContent: rowContent)
            #endif
        } else {
            List(items, rowContent: rowContent)
        }
    }
    
    var body: some View {
        ListBuilder(items: vm.items) { item in
            NavigationLink(value: item) {
                ListTile(listViewModel: vm, list: item)
            }
        }
        .toolbar {
            Button {
                showingSheet.toggle()
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
        .sheet(isPresented: $showingSheet) {
            FormListView(list: nil, listViewModel: vm) {
                showingSheet.toggle()
            }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
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
