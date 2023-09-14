//
//  ListModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

struct ListModelData: Codable {
    let data: [ListModel]
}

struct ListModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let color: String
    let count: Int
    
    enum Count: String, CodingKey  {
        case completed
        case pending
        case total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        color = try container.decode(String.self, forKey: .color)
        
        let countContainer = try container.nestedContainer(keyedBy: Count.self, forKey: .count)
        count = try countContainer.decode(Int.self, forKey: Count.pending)
    }
    
    init(id: Int, name: String, color: String, count: Int) {
        self.id = id
        self.name = name
        self.color = color
        self.count = count
    }
    
    static func preview() -> ListModel {
        return ListModel(id: 1, name: "Work", color: "#FF0000", count: 1)
    }
}
