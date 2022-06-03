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
    func isFirstEntrance() -> Bool
    func setFirstEntrance(_ value: Bool)
    func deleteAllUserInfo()
}

final class UserManager: UserManagerProtocol {
    private enum Keys {
        static let isFirstEntrance = "isFirstEntrance"        
        static let userKey = "userKey"
        static let userEmailCodeKey = "userEmailCodeKey"
    }
    
    private let userDefaults = UserDefaults.standard
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private func setEmailStatus(isVerified: Bool) {
        var user = getUser()
        user.state = isVerified ? .active : .inactive
        saveUser(user)
    }
    
    func getUser() -> User {
        if let savedUser = userDefaults.object(forKey: Keys.userKey) as? Data,
            let decodedUser = try? decoder.decode(User.self, from: savedUser) {
            return decodedUser
        } else {
            return User(email: "", userName: "", password: "", state: .guest)
        }
    }
    
    func saveUser(_ user: User) {
        if let encodedUser = try? encoder.encode(user) {
            userDefaults.set(encodedUser, forKey: Keys.userKey)
        }
    }
    
    func setEmailIsVerified() {
        setEmailStatus(isVerified: true)
    }
    
    func saveEmailCode(_ code: Int) {
        userDefaults.set(code, forKey: Keys.userEmailCodeKey)
        setEmailStatus(isVerified: false)
    }
    
    func getEmailCode() -> Int? {
        return userDefaults.value(forKey: Keys.userEmailCodeKey) as? Int
    }
    
    func updateUserName(_ userName: String) -> User {
        var user = getUser()
        if user.id != -1 {
            user.userName = userName
            saveUser(user)
        }
        return user
    }
    
    func isFirstEntrance() -> Bool {
        return !userDefaults.bool(forKey: Keys.isFirstEntrance)
    }
    
    func setFirstEntrance(_ value: Bool) {
        userDefaults.set(value, forKey: Keys.isFirstEntrance)
    }
    
    func deleteAllUserInfo() {
        userDefaults.removeObject(forKey: Keys.userKey)
        userDefaults.removeObject(forKey: Keys.userEmailCodeKey)
        setFirstEntrance(false)
    }
}

extension UserManagerProtocol {
    func setFirstEntrance() {
        setFirstEntrance(true)
    }
}
