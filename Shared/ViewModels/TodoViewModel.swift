//
//  TodoViewModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import Foundation

@MainActor
class TodoViewModel: ObservableObject {
    let httpService = HttpService()
    
    @Published var items: [TodoModel] = []
    
    func getData(id: Int) async {
        do {
            let response: TodoModelData = try await httpService.fetch(url: "/lists/\(id)/todos")
            self.items = response.data
        } catch {
            print(error)
        }
    }
}
