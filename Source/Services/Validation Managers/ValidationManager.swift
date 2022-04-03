//
//  ValidationManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 03.04.2022.
//

import Foundation

struct ValidationManager: ValidationManagerProtocol {
    // MARK: - Properties
    
    private static let emailRegularExpression = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        + "@"
        + "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        + "[A-Za-z]{2,8}"

    private static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
    
    private static let passwordRegularExpression = "[A-Za-z0-9._%+-@!]{6,16}"

    private static let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegularExpression)
    
    private static let userNameRegularExpression = "[A-Za-z0-9]{4,16}"
    
    private static let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegularExpression)
    
    // MARK: ValidationManagerProtocol
    
    func isValidEmail(_ email: String) -> Bool {
        return ValidationManager.emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return ValidationManager.passwordPredicate.evaluate(with: password)
    }
    
    func isValidUserName(_ userName: String) -> Bool {
        return ValidationManager.userNamePredicate.evaluate(with: userName)
    }
}
