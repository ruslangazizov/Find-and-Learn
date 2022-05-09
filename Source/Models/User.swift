//
//  User.swift
//  Find-and-Learn
//
//  Created by Руслан on 21.03.2022.
//

import Foundation

struct User {
    let id: Int
    let email: String
    let userName: String
    let password: String
    let state: AccountState
    
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

enum AccountState {
    case guest
    case inactive
    case active
}
