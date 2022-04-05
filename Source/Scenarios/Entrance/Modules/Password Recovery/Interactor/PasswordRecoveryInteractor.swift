//
//  PasswordRecoveryInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

final class PasswordRecoveryInteractor: PasswordRecoveryInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    
    // MARK: Init
    
    init(validationManager: ValidationManagerProtocol) {
        self.validationManager = validationManager
    }
    
    // MARK: PasswordRecoveryInteractorProtocol
    
    func recoveryPassword(email: String, _ result: (Bool, String?) -> Void) {
        guard !email.isEmpty else {
            result(false, R.string.localizable.validation_error_empty_email())
            return
        }
        
        if validationManager.isValidEmail(email) {
            // TODO: send to server
            result(true, nil)
        } else {
            result(false, R.string.localizable.validation_error_incorrect_email())
        }
    }
}
