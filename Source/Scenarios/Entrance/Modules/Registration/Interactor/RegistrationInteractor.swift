//
//  RegistrationInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

final class RegistrationInteractor: RegistrationInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
    
    // MARK: RegistrationInteractorProtocol
    
    func registration(
        email: String,
        userName: String,
        password: String,
        confirmPassword: String,
        _ result: (RegistrationResultState) -> Void
    ) {
        guard !email.isEmpty else {
            result(.emailTextField(R.string.localizable.validation_error_empty_email()))
            return
        }
        
        if !validationManager.isValidEmail(email) {
            result(.emailTextField(R.string.localizable.validation_error_incorrect_email()))
        } else if !validationManager.isValidUserName(userName) {
            result(.userNameTextField(R.string.localizable.validation_error_incorrect_user_name()))
        } else if !validationManager.isValidPassword(password) {
            result(.passwordTextField(R.string.localizable.validation_error_incorrect_password()))
        } else if password != confirmPassword {
            result(.confirmPasswordTextField(R.string.localizable.validation_error_password_not_equals()))
        } else {
            // TODO: API request
            result(.success)
        }
    }
}
