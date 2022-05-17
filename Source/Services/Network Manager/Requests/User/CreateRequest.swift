//
//  RegistrationRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation

struct CreateRequestModel: Encodable {
    let id = Int.random(in: 1...1_000_000)
    let firstName: String
    let secondName: String
    let email: String
    let password: String
    let registeredAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case secondName = "second_name"
        case email
        case password = "hashed_password"
        case registeredAt = "registered_at"
    }
}

struct CreateRequest: Request {
    let method: HTTP.Method = .post
    let path: String = "users/"
    let body: HTTP.Body
    
    init(_ model: CreateRequestModel) {
        body = .model(model)
    }
}
