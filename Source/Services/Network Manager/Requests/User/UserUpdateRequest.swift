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
    private(set) var method: HTTP.Method = .put
    private(set) var path: String = "users/"
    private(set) var body: HTTP.Body
    private(set) var token: String
    
    init(_ model: UserUpdateRequestModel, _ id: Int, _ token: String) {
        self.token = token
        path += "\(id)"
        body = .model(.init(model))
    }
}
