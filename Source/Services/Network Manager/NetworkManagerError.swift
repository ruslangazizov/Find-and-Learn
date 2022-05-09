//
//  NetworkManagersError.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 09.05.2022.
//

import Foundation
import Alamofire

enum NetworkManagerError: Error {
    case serverProblem
    case createRequestFailed(Error)
    case serializationFailed
    case invalidUrl
    case unknown
    
    init(_ error: AFError) {
        switch error {
        case .createURLRequestFailed(let error):
            self = .createRequestFailed(error)
        
        case .invalidURL:
            self = .invalidUrl
        
        case .responseSerializationFailed:
            self = .serializationFailed
        
        default:
            self = .unknown
        }
    }
}
