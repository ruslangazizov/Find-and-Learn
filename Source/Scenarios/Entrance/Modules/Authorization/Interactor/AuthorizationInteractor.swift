//
//  AuthorizationInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

final class AuthorizationInteractor: AuthorizationInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
    
    // MARK: AuthorizationInteractorProtocol
    
    func enter(email: String, password: String, _ result: (AuthorizationResultState) -> Void) {
        guard !email.isEmpty else {
            result(.emailTextField(R.string.localizable.validation_error_empty_email()))
            return
        }
        
        if !validationManager.isValidEmail(email) {
            result(.emailTextField(R.string.localizable.validation_error_incorrect_email()))
        } else if !validationManager.isValidPassword(password) {
            result(.passwordTextField(R.string.localizable.validation_error_incorrect_password()))
        } else {
            // TODO: request for API
            result(.success)
        }
    }
}
