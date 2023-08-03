//
//  HttpService.swift
//  TodoSwiftUI
//
//  Created by Carlos Eduardo Umaña Acevedo on 2/8/23.
//

import Foundation

struct HttpService {
    let endPoint = "http://192.168.10.106:8080"
    
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
        case .PUT:
            request.httpMethod = "PUT"
        case .DELETE:
            request.httpMethod = "DELETE"
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HttpServiceError.invalidResponse
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
    case PUT
    case DELETE
}

enum HttpServiceError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
