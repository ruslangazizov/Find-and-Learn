//
//  UserManager.swift
//  Find-and-Learn
//
//  Created by Руслан on 12.05.2022.
//

import Foundation

protocol UserManagerProtocol {
    func getUser(completion: @escaping (User?) -> Void)
    func saveUser(_ user: User)
}

final class UserManager: UserManagerProtocol {
    func getUser(completion: @escaping (User?) -> Void) {
        completion(User(
            email: "testEmail@test.com",
            userName: "Test",
            password: "Hash123456",
            state: .active
        ))
    }
    
    func saveUser(_ user: User) {
    }
}
