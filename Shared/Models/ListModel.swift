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

struct ListModel: Codable, Identifiable {
    let id: Int
    let name: String
    let color: String
}
