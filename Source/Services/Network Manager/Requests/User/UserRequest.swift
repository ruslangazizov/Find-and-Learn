//
//  UserRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 09.05.2022.
//

import Foundation

struct UserRequest: Request {
    private(set) var method: HTTP.Method = .get
    private(set) var path: String = "users/"
    private(set) var token: String
    
    init(_ email: String, _ token: String) {
        self.token = token
        path += email
    }
}
