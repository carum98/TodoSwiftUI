//
//  ListViewModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation
import SwiftUI

@MainActor
class ListViewModel: ObservableObject {
    let httpService = HttpService()
    
    @Published var items: [ListModel] = []
    
    init() {
        Task {
            await self.getData()
        }
    }
    
    func getData() async {
        do {
            let response: ListModelData = try await httpService.fetch(url: "/lists")
            self.items = response.data
        } catch {
            print(error)
        }
    }
    
    func create(name: String, color: Color) async {
        do {
            let data = try? JSONEncoder().encode(["name": name, "color": color.toHex()])
        
            let response: ListModel = try await httpService.fetch(url: "/lists", method: .POST(data: data))
            self.items.insert(response, at: 0)
        } catch {
            print(error)
        }
    }
    
    func update(id: Int, name: String, color: Color) async {
        do {
            let data = try? JSONEncoder().encode(["name": name, "color": color.toHex()])
        
            let response: ListModel = try await httpService.fetch(url: "/lists/\(id)", method: .PUT(data: data))
            
            if let i = self.items.firstIndex(where: { $0.id == response.id }) {
                self.items[i] = response
            }
        } catch {
            print(error)
        }
    }
    
    func remove(id: Int) async {
        do {
            let _: ListModel? = try await httpService.fetch(url: "/lists/\(id)", method: .DELETE)
        } catch {
            print(error)
        }
    }
    
    func changeCount(id: Int, value: Int) {
        if let i = self.items.firstIndex(where: { $0.id == id }) {
            let item = self.items[i]
            self.items[i] = item.copyWith(name: nil, color: nil, count: item.count + value)
        }
    }
}
