//
//  TodoModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 3/8/23.
//

import Foundation

struct TodoModelData: Codable {
    let data: [TodoModel]
}

struct TodoModel: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let is_complete: Bool
    
    static func preview() -> TodoModel {
        return TodoModel(id: 1, title: "Create new project", is_complete: true)
    }
}

struct TodoMessageMove: Codable {
    let message: String
}
