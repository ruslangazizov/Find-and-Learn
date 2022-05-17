//
//  UserUpdateRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 09.05.2022.
//

import Foundation

struct UserUpdateRequestModel: Encodable {
    let firstName: String
    let secondName: String
    let userName: String
    let password: String
}

struct UserUpdateRequest: Request {
    let method: HTTP.Method = .put
    private(set) var path: String = "users/"
    let body: HTTP.Body
    let token: String
    
    init(_ model: UserUpdateRequestModel, _ id: Int, _ token: String) {
        self.token = token
        path += "\(id)"
        body = .model(model)
    }
}
