//
//  TodoView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import SwiftUI

struct TodoView: View {
    @StateObject var vm = TodoViewModel()
    let list: ListModel
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                Text(item.title)
            }
            .onDelete { indexSet in
                vm.items.remove(atOffsets: indexSet)
            }
            .onMove { fromOffset, toOffset in
                vm.items.move(fromOffsets: fromOffset, toOffset: toOffset)
            }
        }
        .toolbar {
            EditButton()
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
