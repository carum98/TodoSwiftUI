//
//  HomeView.swift
//  TodoSwiftUI-iOS
//
//  Created by Carlos Eduardo Umaña Acevedo on 6/8/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var listViewModel = ListViewModel()
    @State private var list: ListModel?
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
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
        } else {
            NavigationStack {
                ListView()
                    .navigationTitle("Lists")
                    .navigationDestination(for: ListModel.self) { item in
                        TodoView(list: item)
                            .navigationTitle(item.name)
                    }
            }
            .environmentObject(listViewModel)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
