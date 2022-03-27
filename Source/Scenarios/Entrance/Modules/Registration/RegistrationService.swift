//
//  RegistrationService.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 26.03.2022.
//

import Foundation

protocol RegistrationAuthSerivce {
    func registerUser(email: String, password: String, confirmPassword: String, nick: String) -> (Bool, String?)
}

final class RegistrationService: RegistrationAuthSerivce {
    // MARK: Properties
    private let emailRegEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    // MARK: RegistrationAuthSerivce
    
    func registerUser(email: String, password: String, confirmPassword: String, nick: String) -> (Bool, String?) {
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEX)
        if !emailPred.evaluate(with: email) { return (false, R.string.localizable.registration_screen_email_error()) }
        
        if nick.isEmpty { return (false, R.string.localizable.registration_screen_nick_error()) }
        
        if confirmPassword != password {
            return (false, R.string.localizable.registration_screen_confirm_password_error())
        }
        
        if password.count < 8 { return (false, R.string.localizable.registration_screen_weak_password_error()) }
        
        return (true, nil)
    }
}
