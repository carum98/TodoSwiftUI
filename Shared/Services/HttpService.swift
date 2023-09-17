//
//  HttpService.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

struct HttpService {
    let authService = AuthViewModel.shared
    let endPoint = "http://localhost:3000"
    
    func fetch<T: Codable>(url: String, method: HttpServiceMethod = .GET) async throws -> T {
        guard let url = URL(string: "\(endPoint)\(url)") else {
            throw HttpServiceError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        
        switch method {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
        case .PUT(let data):
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
        case .DELETE:
            request.httpMethod = "DELETE"
        }
        
        let token = await authService.getToken()
        
        if token != nil {
            request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw HttpServiceError.invalidResponse
        }
        
        if (response.statusCode == 400 || response.statusCode == 404) {
            throw HttpServiceError.invalidResponse
        }
        
        if response.statusCode == 401 {
            await authService.removeToken()
            throw HttpServiceError.unauthorized
        }
        
        do {
            let decoder = JSONDecoder()
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HttpServiceError.invalidData
        }
    }
}

enum HttpServiceMethod {
    case GET
    case POST(data: Data?)
    case PUT(data: Data?)
    case DELETE
}

enum HttpServiceError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case unauthorized
}
