//
//  UserManager.swift
//  Find-and-Learn
//
//  Created by Руслан on 12.05.2022.
//

import Foundation

protocol UserManagerProtocol: AnyObject {
    func getUser() -> User
    func saveUser(_ user: User)
    func setEmailIsVerified()
    func saveEmailCode(_ code: Int)
    func getEmailCode() -> Int?
    func updateUserName(_ userName: String) -> User
}

final class UserManager: UserManagerProtocol {
    private let userDefaults = UserDefaults.standard
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let userKey = "userKey"
    private let userEmailCodeKey = "userEmailCodeKey"
    
    private func setEmailStatus(isVerified: Bool) {
        var user = getUser()
        user.state = isVerified ? .active : .inactive
        saveUser(user)
    }
    
    func getUser() -> User {
        if let savedUser = self.userDefaults.object(forKey: self.userKey) as? Data,
            let decodedUser = try? self.decoder.decode(User.self, from: savedUser) {
            return decodedUser
        } else {
            return User(email: "", userName: "", password: "", state: .guest)
        }
    }
    
    func saveUser(_ user: User) {
        if let encodedUser = try? self.encoder.encode(user) {
            self.userDefaults.set(encodedUser, forKey: self.userKey)
        }
    }
    
    func setEmailIsVerified() {
        setEmailStatus(isVerified: true)
    }
    
    func saveEmailCode(_ code: Int) {
        userDefaults.set(code, forKey: userEmailCodeKey)
        setEmailStatus(isVerified: false)
    }
    
    func getEmailCode() -> Int? {
        return userDefaults.value(forKey: userEmailCodeKey) as? Int
    }
    
    func updateUserName(_ userName: String) -> User {
        var user = getUser()
        user.userName = userName
        saveUser(user)
        return user
    }
}
