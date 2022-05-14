//
//  AuthorizationRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 09.05.2022.
//

import Foundation

struct AuthorizationRequestModel: Encodable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "hashed_password"
    }
}

struct AuthorizationRequest: Request {
    let method: HTTP.Method = .post
    let path: String = "auth/get_token"
    let body: HTTP.Body
    
    init(_ model: AuthorizationRequestModel) {
        body = .model(model)
    }
}
