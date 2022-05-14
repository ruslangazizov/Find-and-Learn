//
//  UserManager.swift
//  Find-and-Learn
//
//  Created by Руслан on 12.05.2022.
//

import Foundation

protocol UserManagerProtocol: AnyObject {
    func getUser(completion: @escaping (User) -> Void)
    func saveUser(_ user: User)
    func setEmailIsVerified()
    func saveEmailCode(_ code: Int)
    func getEmailCode() -> Int?
}

final class UserManager: UserManagerProtocol {
    private let userDefaults = UserDefaults.standard
    
    private let userIdKey = "userIdKey"
    private let userEmailKey = "userEmailKey"
    private let userUsernameKey = "userUsernameKey"
    private let userPasswordKey = "userPasswordKey"
    private let accountIsActiveKey = "accountIsActiveKey"
    private let userEmailCodeKey = "userEmailCodeKey"
    
    func getUser(completion: @escaping (User) -> Void) {
        let userId = userDefaults.integer(forKey: userIdKey)
        let email = userDefaults.string(forKey: userEmailKey)
        let username = userDefaults.string(forKey: userUsernameKey)
        let password = userDefaults.string(forKey: userPasswordKey)
        let accountIsActiveKey = userDefaults.bool(forKey: accountIsActiveKey)
        guard userId != 0, let email = email, let username = username, let password = password else {
            completion(User(email: "", userName: "", password: "", state: .guest))
            return
        }
        
        let state: AccountState = accountIsActiveKey ? .active : .inactive
        completion(User(id: userId, email: email, userName: username, password: password, state: state))
    }
    
    func saveUser(_ user: User) {
        userDefaults.set(user.email, forKey: userEmailKey)
        userDefaults.set(user.userName, forKey: userUsernameKey)
        userDefaults.set(user.password, forKey: userPasswordKey)
        userDefaults.set(false, forKey: accountIsActiveKey)
    }
    
    func setEmailIsVerified() {
        userDefaults.set(true, forKey: accountIsActiveKey)
    }
    
    func saveEmailCode(_ code: Int) {
        userDefaults.set(code, forKey: userEmailCodeKey)
    }
    
    func getEmailCode() -> Int? {
        return userDefaults.value(forKey: userEmailKey) as? Int
    }
}
