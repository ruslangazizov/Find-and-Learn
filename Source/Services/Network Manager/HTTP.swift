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
