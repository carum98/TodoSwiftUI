//
//  AuthViewModel.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    private let name = "token"
    private let defaults = UserDefaults.standard
    
    @Published var isAuth = false
    
    static let shared = AuthViewModel()
    
    private init() {
        isAuth = getToken() != nil
    }
    
    func getToken() -> String? {
        guard let token = defaults.string(forKey: name) else {
            return nil
        }
        
        return token
    }
    
    func setToken(token: String) {
        self.isAuth = true
        defaults.setValue(token, forKey: name)
        
        print("log in")
    }
    
    func removeToken() {
        self.isAuth = false
        defaults.removeObject(forKey: name)
        
        print("removeToken")
        print(self.isAuth)
    }
}
