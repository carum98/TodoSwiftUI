//
//  LoginViewModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    let httpService: HttpService
    
    @Published var userName = ""
    @Published var password = ""
    
    @Published var token = ""
    
    init(httpService: HttpService) {
        self.httpService = httpService
    }
    
    func login() async -> Bool {
        do {
            let data = try? JSONEncoder().encode(["user_name": userName, "password": password])
            
            let response: AuthModel = try await httpService.fetch(url: "/login", method: .POST(data: data))
            
            DispatchQueue.main.async {
                self.token = response.token
            }
            
            return true
        } catch {
            print(error)
            return false
        }
    }
}
