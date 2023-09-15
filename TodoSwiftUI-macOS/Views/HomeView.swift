//
//  HomeView.swift
//  TodoSwiftUI-macOS
//
//  Created by Carlos Eduardo Umaña Acevedo on 6/8/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var listViewModel = ListViewModel()
    @State private var list: ListModel?
    
    var body: some View {
        NavigationSplitView {
            ListView(selected: $list)
                .navigationTitle("Lists")
        } detail: {
            if let item = list {
                TodoView(list: item)
                    .navigationTitle(item.name)
            } else {
              Text("Select list")
                    .navigationTitle("Todo")
            }
        }
        .navigationSplitViewStyle(.balanced)
        .environmentObject(listViewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
