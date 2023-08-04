//
//  AppView.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import SwiftUI

struct AppView: View {
    @StateObject var authViewModel = AuthViewModel.shared
    
    @State private var list: ListModel?
    
    var body: some View {
        if authViewModel.isAuth {
            NavigationSplitView {
                ListView(selected: $list)
                    .navigationTitle("Lists")
            } detail: {
                if let item = list {
                    TodoView(list: item)
                        .navigationTitle(item.name)
                } else {
                  Text("Select list")
                }
            }.navigationSplitViewStyle(.balanced)
        } else {
            LoginView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
