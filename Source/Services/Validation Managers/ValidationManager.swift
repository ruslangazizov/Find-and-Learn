//
//  ValidationManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 03.04.2022.
//

import Foundation

protocol ValidationManagerProtocol: AnyObject {
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
    func isValidUserName(_ userName: String) -> Bool
    func areEnglishCharacters(_ text: String) -> Bool
}

final class ValidationManager: ValidationManagerProtocol {
    // MARK: Properties
    
    private static let emailRegularExpression = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        + "@"
        + "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        + "[A-Za-z]{2,8}"

    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
    
    private static let passwordRegularExpression = "[A-Za-z0-9._%+-@!]{6,16}"

    private let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegularExpression)
    
    private static let userNameRegularExpression = "[A-Za-z0-9]{4,16}"
    
    private let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegularExpression)
    
    private static let englishCharactersExpression = "[a-zA-z]+"
    
    private let englishCharactersPredicate = NSPredicate(format: "SELF MATCHES %@", englishCharactersExpression)
    
    // MARK: ValidationManagerProtocol
    
    func isValidEmail(_ email: String) -> Bool {
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return passwordPredicate.evaluate(with: password)
    }
    
    func isValidUserName(_ userName: String) -> Bool {
        return userNamePredicate.evaluate(with: userName)
    }
    
    func areEnglishCharacters(_ text: String) -> Bool {
        return englishCharactersPredicate.evaluate(with: text)
    }
}
