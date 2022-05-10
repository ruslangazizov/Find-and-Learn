//
//  RegistrationRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation

struct RegistrationRequestModel: Encodable {
    let id = Int.random(in: 0...1_000_000)
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

struct RegistrationRequest: Request {
    private(set) var method: HTTP.Method = .post
    private(set) var path: String = "users/"
    private(set) var body: HTTP.Body
    
    init(_ model: RegistrationRequestModel) {
        body = .model(.init(model))
    }
}
