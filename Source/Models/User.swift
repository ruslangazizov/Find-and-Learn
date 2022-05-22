//
//  User.swift
//  Find-and-Learn
//
//  Created by Руслан on 21.03.2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    var userName: String
    let password: String
    var state: AccountState
    
    init(
        id: Int = -1,
        email: String,
        userName: String,
        password: String,
        state: AccountState
    ) {
        self.id = id
        self.email = email
        self.userName = userName
        self.password = password
        self.state = state
    }
}

enum AccountState: Codable {
    case guest
    case inactive
    case active
}
