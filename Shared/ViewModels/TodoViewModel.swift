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
    
    func toggle(todo: TodoModel) async {
        do {
            let response: TodoModel = try await httpService.fetch(url: "/todos/\(todo.id)/toggle", method: .POST(data: nil))
            
            if let index = items.firstIndex(of: todo) {
                items[index] = response
            }
        } catch {
            print(error)
        }
    }
    
    func move(todo: TodoModel, position: Int) async {
        do {
            let data = try JSONEncoder().encode(["position": position])
            let _: TodoMessageMove = try await httpService.fetch(url: "/todos/\(todo.id)/move", method: .POST(data: data))
        } catch {
            print(error)
        }
    }
    
    func create(list: ListModel, title: String) async {
        do {
            let data = try JSONEncoder().encode(["title": title])
            let response: TodoModel = try await httpService.fetch(url: "/lists/\(list.id)/todos", method: .POST(data: data))
            
            self.items.append(response)
        } catch {
            print(error)
        }
    }
    
    func update(todo: TodoModel, title: String) async {
        do {
            let data = try? JSONEncoder().encode(["title": title])
        
            let response: TodoModel = try await httpService.fetch(url: "/todos/\(todo.id)", method: .PUT(data: data))
            
            if let i = self.items.firstIndex(of: todo) {
                self.items[i] = response
            }
        } catch {
            print(error)
        }
    }
    
    func remove(todo: TodoModel) async {
        do {
            let _: ListModel? = try await httpService.fetch(url: "/todos/\(todo.id)", method: .DELETE)
        } catch {
            print(error)
        }
    }
}
