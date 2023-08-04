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
            }
        }
        .task {
            await vm.getData()
        }
        #endif
    }
}
