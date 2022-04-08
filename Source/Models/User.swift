//
//  User.swift
//  Find-and-Learn
//
//  Created by Руслан on 21.03.2022.
//

import Foundation

struct User {
    let email: String
    let password: String
    let state: AccountState
}

enum AccountState {
    case guest
    case inactive
    case active
}
