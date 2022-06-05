//
//  HTTP.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation

enum HTTP {
    typealias Queries = [String: CustomStringConvertible]
    
    typealias Headers = [String: String]
   
    enum Body: Equatable {
        case raw(Data)
        case model(Encodable)
        case keyValue([String: Any])
        case none
        // TODO: (r.akhmadeev) Реализация не верная. Для чего вообще нужно реализовывать Equatable?
        static func == (lhs: HTTP.Body, rhs: HTTP.Body) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none):
                return true
            default:
                return false
            }
        }
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
    // TODO: (r.akhmadeev) Уже есть NetworkManagerError. Не понятно для чего этот нужен
    enum Errors: Error {
        case incorrectUrl(String)
    }
    
    enum StatusCode {
        static let server = 500...599
    }
    
    enum Auth {
        static let tokenType = "bearer"
    }
}
