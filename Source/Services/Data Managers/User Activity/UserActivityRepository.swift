//
//  UserActivityRepository.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 22.05.2022.
//

import Foundation

protocol UserActivityRepositoryProtocol {
    func isFirstEntrance() -> Bool
    func setFirstEntrance(_ value: Bool)
}

final class UserActivityRepository: UserActivityRepositoryProtocol {
    private enum Keys {
        static let isFirstEntrance = "isFirstEntrance"
    }
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: UserActivityRepositoryProtocol
    
    func isFirstEntrance() -> Bool {
        return !userDefaults.bool(forKey: Keys.isFirstEntrance)
    }
    
    func setFirstEntrance(_ value: Bool) {
        userDefaults.set(value, forKey: Keys.isFirstEntrance)
    }
}

extension UserActivityRepositoryProtocol {
    func setFirstEntrance() {
        setFirstEntrance(true)
    }
}
