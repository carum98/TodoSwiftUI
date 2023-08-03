//
//  ListViewModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

@MainActor
class ListViewModel: ObservableObject {
    let httpService = HttpService()
    
    @Published var items: [ListModel] = []
    
    func getData() async {
        do {
            let response: ListModelData = try await httpService.fetch(url: "/lists")
            self.items = response.data
        } catch {
            print(error)
        }
    }
}
