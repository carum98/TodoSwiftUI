//
//  HomeView.swift
//  TodoSwiftUI-macOS MenuBar App
//
//  Created by Carlos Eduardo Umaña Acevedo on 8/8/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var listViewModel = ListViewModel()
    
    var body: some View {
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .frame(width: 200)
    }
}
