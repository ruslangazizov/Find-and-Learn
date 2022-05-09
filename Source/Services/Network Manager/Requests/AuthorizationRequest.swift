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
    private(set) var method: HTTP.Method = .post
    private(set) var path: String = "get_token"
    private(set) var body: HTTP.Body
    
    init(_ model: AuthorizationRequestModel) {
        body = .model(.init(model))
    }
}
