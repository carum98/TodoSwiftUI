//
//  AuthModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

struct AuthModel: Codable {
    let token: String
    let refreshToken: String
}
