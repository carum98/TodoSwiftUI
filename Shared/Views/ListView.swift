//
//  ListView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var vm = ListViewModel()
    
    var body: some View {
        List(vm.items) { item in
            HStack {
                Image(systemName: "circle.fill")
                  .frame(width: 20, height: 20)
                  .foregroundColor(Color(hex: item.color))
                Text(item.name)
            }
        }
        .task {
            await vm.getData()
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
